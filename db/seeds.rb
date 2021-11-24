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

d = Dashboard.new(name: "First Pilot", user_id: 2)
d.save
d = Dashboard.new(name: "Second Pilot", user_id: 2)
d.save

vs_currency = "USD"
limit = 150

gecko_api = URI.open("https://api.coingecko.com/api/v3/coins/markets?vs_currency=#{vs_currency}&per_page=#{limit}&page=1&sparkline=false")
json = JSON.parse(gecko_api.read)
json.each do |d|
  Asset.create(id_name: d["id"], rank: d["market_cap_rank"], name: d["name"], symbol: d["symbol"], image: d["image"])
end
puts "💵 Created #{limit} assets"

t = Transaction.new(direction: "Buy", asset_name: "name", quantity: "1", price: "100", date: "2021-11-10", dashboard_id: 1, asset_id: 2)
t.save
t = Transaction.new(direction: "Buy", asset_name: "name", quantity: "4", price: "500", date: "2021-11-20", dashboard_id: 1, asset_id: 1)
t.save
t = Transaction.new(direction: "Sell", asset_name: "name", quantity: "1", price: "2500", date: "2021-11-22", dashboard_id: 1, asset_id: 1)
t.save
t = Transaction.new(direction: "Sell", asset_name: "name", quantity: "1", price: "3000", date: "2021-11-23", dashboard_id: 1, asset_id: 1)
t.save
t = Transaction.new(direction: "Buy", asset_name: "name", quantity: "2", price: "2000", date: "2021-11-12", dashboard_id: 2, asset_id: 3)
t.save
t = Transaction.new(direction: "Buy", asset_name: "name", quantity: "4", price: "3000", date: "2021-11-11", dashboard_id: 2, asset_id: 4)
t.save
t = Transaction.new(direction: "Sell", asset_name: "name", quantity: "2", price: "5000", date: "2024-11-20", dashboard_id: 2, asset_id: 4)
t.save
t = Transaction.new(direction: "Sell", asset_name: "name", quantity: "1", price: "4000", date: "2021-11-21", dashboard_id: 2, asset_id: 4)
t.save

puts "✅ Databse seeded!"
