class Dashboard < ApplicationRecord
  serialize :asset
  belongs_to :user
  has_many :transactions

  def check_transactions_equality
    registered_transactions = self.transactions
    counted_transactions = @transactions.length
    registered_transactions == counted_transactions
  end

  def assets_id_list
    @assets_id_list = []
    @transactions.each do |transaction|
      if @assets_id_list.include?(Asset.find(transaction.asset_id).id)
        next
      else
        @assets_id_list << Asset.find(transaction.asset_id).id
      end
    end
  end

  def asset_qty(asset_id)
    asset_transactions = @transactions.where("asset_id = #{asset_id}")
    buy_transactions = asset_transactions.where("direction = 'buy'")
    sell_transactions = asset_transactions.where("direction = 'sell'")
    buying_sum = 0
    buy_transactions.each do |transaction|
      buying_sum += transaction.quantity
    end
    selling_sum = 0
    sell_transactions.each do |transaction|
      selling_sum += transaction.quantity
    end
    return buying_sum - selling_sum
  end

  def asset_total_spent(asset_id)
    asset_transactions = @transactions.where("asset_id = #{asset_id}")
    buy_transactions = asset_transactions.where("direction = 'buy'")
    total_spent = 0
    buy_transactions.each do |transaction|
      total_spent += (transaction.quantity * transaction.price)
    end
    return total_spent
  end

  def tokens_bought(asset_id)
    asset_transactions = @transactions.where("asset_id = #{asset_id}")
    buy_transactions = asset_transactions.where("direction = 'buy'")
    token_bought = 0
    buy_transactions.each do |transaction|
      token_bought += transaction.quantity
    end
    return token_bought
  end

  def create_hash(date)
    @transactions = Transaction.where("dashboard_id = #{self.id} AND date <= ?", date)
    assets_id_list
    assets = {}
    @assets_id_list.each do |asset_id|
      assets[asset_id.to_s] = {
        name: Asset.find(asset_id).name,
        quantity: asset_qty(asset_id),
        total_spent: asset_total_spent(asset_id),
        number_of_transaction: Transaction.where("asset_id = #{asset_id}").length,
        average_cost: (asset_total_spent(asset_id) / tokens_bought(asset_id))
      }
    end
    return assets
  end

  def assets_market_price
    # ! Use real price when API calls are ready
    @assets_keys.each do |asset_key|
      @assets[asset_key.to_s][:market_price] = 1000
    end
  end

  def assets_pnl
    @assets_keys.each do |asset_key|
      asset = @assets[asset_key.to_s]
      asset[:pnl] = (asset[:market_price] - asset[:average_cost]) * asset[:quantity]
    end
  end

  def define_assets(date)
    @assets = create_hash(date)
    @assets = self.asset if !self.asset.nil? && check_transactions_equality
    @assets_keys = @assets.keys
    assets_market_price
    assets_pnl
    p @assets
    return @assets
  end

  def total_value(assets)
    total_value = 0
    assets.keys.each do |key|
      value = assets[key][:quantity] * assets[key][:market_price]
      total_value += value
    end
    return total_value
  end

  def total_pnl(assets)
    total_pnl = 0
    assets.keys.each do |key|
      pnl = assets[key][:pnl]
      total_pnl += pnl
    end
    return total_pnl
  end

  def values
    # la première date est celle de la premiere
    @transactions = self.transactions.order('date ASC')
    first_date = @transactions.first.date
    number_of_days = (Date.today - first_date).to_i + 1
    dates = []
    i = 0
    number_of_days.times do
      dates << (first_date + i)
      i += 1
    end
    # la dernière date est celle d'aujourd'hui
    values = dates.map do |date|
      [date, self.total_value(define_assets(date))]
    end
    return values
  end
end
