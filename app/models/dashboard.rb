class Dashboard < ApplicationRecord
  belongs_to :user
  has_many :transactions

  def check_transactions_equality
    registered_transactions = self.transactions
    counted_transactions = Transaction.where("dashboard_id = #{self.id}").length
    registered_transactions == counted_transactions
  end

  def assets_id_list
    @assets_id_list = []
    @transactions.each do |transaction|
      if @assets_id_list.include?(Asset.find(transaction.asset_id))
        next
      else
        @assets_id_list << Asset.find(transaction.asset_id)
      end
    end
  end

  def asset_qty(asset_id)
    asset_transactions = Transaction.where("asset_id = #{asset_id}")
    buy_transactions = asset_transactions.where("direction = buy")
    sell_transactions = asset_transactions.where("direction = sell")
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
    asset_transactions = Transaction.where("asset_id = #{asset_id}")
    buy_transactions = asset_transactions.where("direction = buy")
    total_spent = 0
    buy_transactions.each do |transaction|
      total_spent += (transaction.quantity * transaction.price)
    end
    return total_spent
  end

  def create_hash
    @transactions = Transaction.where("dashboard_id = #{self.id}")
    assets_id_list
    assets = {}
    @assets_id_list.each do |asset_id|
      assets[asset.to_sym] = {
        name: Asset.find(asset_id).name,
        # Compute quantity for each
        quantity: asset_qty(asset_id),
        # Compute total spent for each
        total_spent: total_spent(asset_id),
        # Compute number of transactions
        number_of_transaction: Transactions.where("asset_id = #{asset_id}").length,
        # Compute average cost
        average_cost: (total_spent(asset_id) / asset_qty(asset_id))
      }
    end
  end

  def assets_market_price
    # ! Use real price when API calls are ready
    @assets_keys.each do |asset|
      @assets[asset.to_sym][market_price] = 1000
    end
  end

  def assets_pnl
    @assets_keys.each do |asset_key|
      asset = @assets[asset_key.to_sym]
      asset[pnl] = (asset[market_price] - asset[average_cost]) * asset[quantity]
    end
  end

  def define_assets
    if self.asset.nil?
      # Create the hash
      self.asset = create_hash
      @assets = self.asset
      @assets_keys = @assets.keys
    else
      if check_transactions_equality
        @assets = self.asset
        @assets_keys = @assets.keys
      else
        # Create the hash
        self.asset = create_hash
        @assets = self.asset
        @assets_keys = @assets.keys
      end
    end
    assets_market_price
    assets_pnl
  end
end
