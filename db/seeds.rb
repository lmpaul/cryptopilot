# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u = User.new(email: "admin@cryptopilot.com", username: "admin", password: "azerty")
u.save

u = User.new(email: "paul@cryptopilot.com", username: "Paul", password: "azerty")
u.save

d = Dashboard.new(name: "Premier dashboard", user_id: 2)
d.save
d = Dashboard.new(name: "Deuxième dashboard", user_id: 2)
d.save

limit = 500
res_api = URI.open("https://pro-api.coinmarketcap.com/v1/cryptocurrency/map",
                  'X-CMC_PRO_API_KEY' => '0afa05e5-36e7-4bdd-b0f7-318edac9d63d')
json = JSON.parse(res_api.read)
json["data"].each do |d|
  Asset.create(coin_mcap_id: d["id"], rank: d["rank"], name: d["name"], symbol: d["symbol"]) if d["rank"] < limit
end
p "💵 Created #{limit} assets"

t = Transaction.new(direction: "buy", asset_name: "name", quantity: "1", price: "100", date: "2021-11-20", dashboard_id: 1, asset_id: 2)
t.save
t = Transaction.new(direction: "buy", asset_name: "name", quantity: "4", price: "500", date: "2021-11-10", dashboard_id: 1, asset_id: 1)
t.save
t = Transaction.new(direction: "sell", asset_name: "name", quantity: "1", price: "2500", date: "2021-11-22", dashboard_id: 1, asset_id: 1)
t.save
t = Transaction.new(direction: "sell", asset_name: "name", quantity: "1", price: "3000", date: "2021-11-23", dashboard_id: 1, asset_id: 1)
t.save

t = Transaction.new(direction: "buy", asset_name: "name", quantity: "2", price: "200", date: "2021-11-20", dashboard_id: 2, asset_id: 3)
t.save
t = Transaction.new(direction: "buy", asset_name: "name", quantity: "4", price: "300", date: "2021-11-10", dashboard_id: 2, asset_id: 4)
t.save
t = Transaction.new(direction: "sell", asset_name: "name", quantity: "2", price: "500", date: "2024-11-22", dashboard_id: 2, asset_id: 4)
t.save
t = Transaction.new(direction: "sell", asset_name: "name", quantity: "1", price: "400", date: "2021-11-23", dashboard_id: 2, asset_id: 4)
t.save

puts "✅ Databse seeded!"
