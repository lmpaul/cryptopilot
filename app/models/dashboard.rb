class Dashboard < ApplicationRecord
  serialize :asset
  belongs_to :user
  has_many :transactions, dependent: :destroy
  validates :name, presence: true

  def average_cost_price(asset_id, date)
    asset_total_spent(asset_id) / tokens_bought(asset_id, date)
  end

  def market_price(asset_id, date)
    return PriceHistory.where("id_name = '#{Asset.find(asset_id).id_name}' AND date = ?", date).last.price
  end

  # Permet de cacluler le nombre de token achetés pour un actif depuis le début
  def tokens_bought(asset_id, date)
    transactions = Transaction.where("dashboard_id = #{self.id} AND date <= ?", date)
    asset_transactions = transactions.where("asset_id = #{asset_id}")
    buy_transactions = asset_transactions.where("direction = 'Buy'")
    token_bought = 0
    buy_transactions.each do |transaction|
      token_bought += transaction.quantity
    end
    return token_bought
  end

  # Permet de calculer le montant dépensé dans un asset depuis le début du pilot
  def asset_total_spent(asset_id)
    asset_transactions = @transactions.where("asset_id = #{asset_id}")
    buy_transactions = asset_transactions.where("direction = 'Buy'")
    total_spent = 0
    buy_transactions.each do |transaction|
      total_spent += (transaction.quantity * transaction.price)
    end
    return total_spent
  end

  def compute_buying_sum(buy_transactions)
    buying_sum = 0
    buy_transactions.each do |transaction|
      buying_sum += transaction.quantity
    end
    return buying_sum
  end

  def compute_selling_sum(sell_transactions)
    selling_sum = 0
    sell_transactions.each do |transaction|
      selling_sum += transaction.quantity
    end
    return selling_sum
  end

  # Permet de calculer le nombre de coins actuellement dans le pilot pour chaque asset
  def asset_qty(asset_id, date)
    asset_transactions = @transactions.where("asset_id = #{asset_id} AND date <= ?", date)
    buy_transactions = asset_transactions.where("direction = 'Buy'")
    sell_transactions = asset_transactions.where("direction = 'Sell'")
    buying_sum = compute_buying_sum(buy_transactions)
    selling_sum = compute_selling_sum(sell_transactions)
    return buying_sum - selling_sum
  end

  # Permet de créer la première partie du hash pour ce qu'il y a aujourd'hui dans le pilot
  def create_hash(date)
    assets = {}
    @assets_id_list.each do |asset_id|
      assets[Asset.find(asset_id).id_name] = {
        id: asset_id,
        quantity: asset_qty(asset_id, date),
        total_spent: asset_total_spent(asset_id),
        number_of_transaction: @transactions.where("asset_id = #{asset_id}").length,
        average_cost:
        if tokens_bought(asset_id, date).zero?
          0
        else
          average_cost_price(asset_id, date)
        end,
        market_price: market_price(asset_id, date),
        pnl:
        (market_price(asset_id, date) * asset_qty(asset_id, date)) -
        (average_cost_price(asset_id, date) * asset_qty(asset_id, date)),
        date: date
      }
    end
    return assets
  end

  # Permet de récupérer la liste des id des assets actuellement dans le pilot
  def assets_id_list
    @assets_id_list = []
    transactions = Transaction.where("dashboard_id = #{self.id}")
    transactions.each do |transaction|
      next if @assets_id_list.include?(Asset.find(transaction.asset_id).id)

      @assets_id_list << Asset.find(transaction.asset_id).id
    end
  end

  # Permet de metter à jour la table des historiques des prix par asset et par date
  def update_price_history(asset, json)
    json["prices"].each do |element|
      price = PriceHistory.find_by(date: Time.at(element[0]/1000).to_date, id_name: asset.id_name)
      if price.nil?
        PriceHistory.create(id_name: asset.id_name, date: Time.at(element[0]/1000).to_date, price: element[1], asset_id: asset.id)
      else
        price.update(id_name: asset.id_name, date: Time.at(element[0]/1000).to_date, price: element[1], asset_id: asset.id)
      end
    end
  end

  # Permet d'obtenir l'historique des prix des actifs du wallet
  def get_history(number_of_days)
    vs_currency = "USD"
    assets_id_list # permet de définir @assets_id_list
    @assets_id_list.each do |asset_key|
      asset = Asset.find(asset_key.to_i)
      res_api = URI.open("https://api.coingecko.com/api/v3/coins/#{asset.id_name}/market_chart?vs_currency=#{vs_currency}&days=#{number_of_days}&interval=daily")
      json = JSON.parse(res_api.read)
      json["prices"].delete_at(-2)
      update_price_history(asset, json)
    end
  end

  # Permet de récupérer toutes les dates depuis la première transac à aujourd'hui + le nb de jour que cela représente
  def define_dates(transactions)
    first_date = transactions.first.date
    number_of_days = (Date.today - first_date).to_i + 1
    dates = []
    i = 0
    number_of_days.times do
      dates << (first_date + i)
      i += 1
    end
    return [number_of_days, dates]
  end

  # Permet de créer le hash complet avec les actifs du pilot pour chaque jour depuis le début
  def define_assets
    return [0] if self.transactions == []

    @transactions = self.transactions.order('date ASC')
    dates = define_dates(@transactions)[1]
    get_history(define_dates(@transactions)[0])

    daily_hash = dates.map do |date|
      create_hash(date)
    end
    p daily_hash
    return daily_hash
  end

  # Permet de calculer la valeur total du pilot pour un hash (jour) donné
  def total_value(hash)
    total_value = 0
    keys = hash.keys
    keys.each do |key|
      total_value += hash[key][:quantity] * hash[key][:market_price]
    end
    return total_value
  end

  def charts
    transactions = self.transactions.order('date ASC')
    assets = define_assets
    chart_values = values(transactions, assets)
    pie_values = pie(assets)
    return [chart_values, pie_values]
  end

  # Permet de générer les données pour le graph
  def values(transactions, assets)
    dates = define_dates(transactions)[1]
    values = dates.map do |date|
      [date, total_value(assets[dates.index(date)])]
    end
    return values
  end

  # Permet de calculer le pourcentage que représente chaque asset dans le pilot pour aujourd'hui
  def percentage(assets)
    assets = positive_assets(assets.last)
    total_value = total_value(assets)
    keys = assets.keys
    keys.each do |key|
      assets[key][:percentage] = (assets[key][:quantity] * assets[key][:market_price]) / total_value * 100
    end
    return assets
  end

  # Permet de générer les valeurs pour le pie chart du pilot (date = aujourd'hui)
  def pie(assets)
    assets = percentage(assets)
    keys = assets.keys
    pie_array = keys.map do |key|
      {
        name: key,
        y: assets[key][:percentage].round(2),
        drilldown: key
      }
    end
    return pie_array
  end

  # Permet de calculer la PnL total d'un pilot pour un hash (jour) donné
  def total_pnl(asset_hash)
    keys = asset_hash.keys
    total = 0
    keys.each do |key|
      total += asset_hash[key][:pnl]
    end
    return total
  end

  def sparklines
    keys = define_assets.last.keys
    prices = {}
    keys.each do |key|
      history = PriceHistory.where("id_name = '#{key}'")
      prices[key] = history.map do |value|
        [value.date, value.price.round(2)]
      end
    end
    prices = order_prices(prices)
    return prices
  end

  def order_prices(prices)
    keys = prices.keys
    keys.each do |key|
      prices[key] = prices[key].sort { |a, b| a[0] <=> b[0] }
    end
    return prices
  end

  def positive_assets(assets)
    keys = assets.keys
    positive_assets = {}
    keys.each do |key|
      positive_assets[key] = assets[key] if assets[key][:quantity].positive?
    end
    return positive_assets
  end
end
