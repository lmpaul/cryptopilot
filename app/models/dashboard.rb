class Dashboard < ApplicationRecord
  serialize :asset
  belongs_to :user
  has_many :transactions
  validates :name, presence: true

  # Permet de récupérer la liste des id des assets actuellement dans le pilot
  # ! Il faut gérer le cas où un actif revient à zero
  def assets_id_list
    @assets_id_list = []
    transactions = Transaction.where("dashboard_id = #{self.id}")
    transactions.each do |transaction|
      if @assets_id_list.include?(Asset.find(transaction.asset_id).id)
        next
      else
        @assets_id_list << Asset.find(transaction.asset_id).id
      end
    end
  end

  # Permet de calculer le nombre de coins actuellement dans le pilot pour chaque asset
  def asset_qty(asset_id, date)
    transactions = Transaction.where("dashboard_id = #{self.id}")
    asset_transactions = transactions.where("asset_id = #{asset_id} AND date <= ?", date)
    buy_transactions = asset_transactions.where("direction = 'Buy'")
    sell_transactions = asset_transactions.where("direction = 'Sell'")
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

  # Permet de calculer le montant dépensé dans un asset depuis le début du pilot
  def asset_total_spent(asset_id)
    transactions = Transaction.where("dashboard_id = #{self.id}")
    asset_transactions = transactions.where("asset_id = #{asset_id}")
    buy_transactions = asset_transactions.where("direction = 'Buy'")
    total_spent = 0
    buy_transactions.each do |transaction|
      total_spent += (transaction.quantity * transaction.price)
    end
    return total_spent
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

  # Permet de créer la première partie du hash pour ce qu'il y a aujourd'hui dans le pilot
  def create_hash(date)
    assets_id_list
    assets = {}
    @assets_id_list.each do |asset_id|
      assets[Asset.find(asset_id).id_name] = {
        id: asset_id,
        quantity: asset_qty(asset_id, date),
        total_spent: asset_total_spent(asset_id),
        number_of_transaction: Transaction.where("dashboard_id = #{self.id} AND asset_id = #{asset_id}").length,
        average_cost: tokens_bought(asset_id,date) == 0 ? 0 : (asset_total_spent(asset_id) / tokens_bought(asset_id, date)),
        market_price: PriceHistory.where("id_name = '#{Asset.find(asset_id).id_name}' AND date = ?", date).last.price,
        pnl: (PriceHistory.where("id_name = '#{Asset.find(asset_id).id_name}' AND date = ?", date).last.price) - (tokens_bought(asset_id,date) == 0 ? 0 : (asset_total_spent(asset_id) / tokens_bought(asset_id, date))),
        date: date
      }
    end
    return assets
  end

  # Permet d'obtenir l'historique des prix des actifs du wallet
  def get_history(number_of_days)
    #chercher le price de chaques asset par dates et le mettre dans Pricehistorys
    vs_currency = "USD"
    assets_id_list
    PriceHistory.destroy_all
    @assets_id_list.each do |asset_key|
      asset = Asset.find(asset_key.to_i)
      res_api = URI.open("https://api.coingecko.com/api/v3/coins/#{asset.id_name}/market_chart?vs_currency=#{vs_currency}&days=#{number_of_days}&interval=daily")
      json = JSON.parse(res_api.read)
      json["prices"].each do |element|
        PriceHistory.create(id_name: asset.id_name, date: Time.at(element[0]/1000).to_date, price: element[1], asset_id: asset.id)
      end
    end
    @assets_id_list.each do |asset_key|
      a = PriceHistory.where("id_name ='#{Asset.find(asset_key).id_name}'")
      a[number_of_days - 1].destroy
    end
  end


  # Permet de calculer le nombre de jour depuis la première tx à aujourd'hui
  def compute_number_of_days
    transactions = self.transactions.order('date ASC')
    first_date = transactions.first.date
    number_of_days = (Date.today - first_date).to_i + 1

    return number_of_days
  end

  # Permet de récupérer toutes les dates depuis la première transac à aujourd'hui
  def get_dates
    transactions = self.transactions.order('date ASC')
    first_date = transactions.first.date
    number_of_days = compute_number_of_days
    dates = []
    i = 0
    number_of_days.times do
      dates << (first_date + i)
      i += 1
    end
    return dates
  end

  # TODO : Permet de créer le hash complet avec les actifs du pilot pour chaque jour depuis le début
  def define_assets
    days = get_dates
    get_history(compute_number_of_days)

    daily_hash = days.map do |day|
      create_hash(day)
    end

    p daily_hash
    return daily_hash
  end

  # # TODO: Permet de calculer la valeur total du pilot à une date donnée
  def total_value(hash)
    total_value = 0
    keys = hash.keys
    keys.each do |key|
      total_value += hash[key][:quantity] * hash[key][:market_price]
    end
    return total_value
  end

  # # TODO: Permet de calculer la pnl totale du pilot à une date donnée
  # def total_pnl(assets)
  #   # total_pnl = 0
  #   # assets.keys.each do |key|
  #   #   pnl = assets[key][:pnl]
  #   #   total_pnl += pnl
  #   # end
  #   return 0
  # end

  # # TODO: Permet de générer les données pour le graph
  def values
    dates = get_dates
    array = define_assets
    values = dates.map do |date|
      [date, total_value(array[dates.index(date)])]
    end
    return values
  end

  def percentage
    assets = define_assets.last
    total_value = total_value(assets)
    keys = assets.keys
    keys.each do |key|
      assets[key][:percentage] = (assets[key][:quantity] * assets[key][:market_price]) / total_value * 100
    end
    return assets
  end

  def pie
    assets = percentage()
    p assets
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
end
