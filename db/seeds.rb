# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

vs_currency = "USD"
limit = 150

gecko_api = URI.open("https://api.coingecko.com/api/v3/coins/markets?vs_currency=#{vs_currency}&per_page=#{limit}&page=1&sparkline=false")
json = JSON.parse(gecko_api.read)
json.each do |d|
  Asset.create(id_name: d["id"], rank: d["market_cap_rank"], name: d["name"], symbol: d["symbol"], image: d["image"])
end

puts "💵 Created #{limit} assets"

u = User.new(email: "paul@cryptopilot.com", username: "Paul", password: "azerty")
u.save

d = Dashboard.new(name: "My First Pilot", user_id: 1)
d.save

t = Transaction.new(direction: "Buy", asset_name: "name", quantity: "1", price: "200", date: "2021-11-01", dashboard_id: 1, asset_id: 5)
t.save

puts "✅ Databse seeded!"
