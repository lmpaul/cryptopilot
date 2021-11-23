# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

limit = 500
res_api = URI.open("https://pro-api.coinmarketcap.com/v1/cryptocurrency/map",
                  'X-CMC_PRO_API_KEY' => '0afa05e5-36e7-4bdd-b0f7-318edac9d63d')
json = JSON.parse(res_api.read)
json["data"].each do |d|
  Asset.create(coin_mcap_id: d["id"], rank: d["rank"], name: d["name"], symbol: d["symbol"]) if d["rank"] < limit
end
p "created #{limit} assets"
