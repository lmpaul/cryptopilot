# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create a user
# Create a dashboard
# Create 1 assets
# Create 4 transaction

u = User.new(email: "paul@cryptopilot.com", username: "Paul", password: "azerty")
u.save

d = Dashboard.new(name: "Dashboard de test", user_id: 1)
d.save

a = Asset.new(coin_mcap_id: 1, rank: 1, name: "bitcoin", symbol:"BTC")
a.save

a = Asset.new(coin_mcap_id: 2, rank: 20, name: "litecoin", symbol:"LTC")
a.save

t = Transaction.new(direction: "buy", asset_name: "litecoin", quantity: "1", price: "100", date: "2021-11-20", dashboard_id: 1, asset_id: 2)
t.save
t = Transaction.new(direction: "buy", asset_name: "bitcoin", quantity: "4", price: "500", date: "2021-11-10", dashboard_id: 1, asset_id: 1)
t.save
t = Transaction.new(direction: "sell", asset_name: "bitcoin", quantity: "1", price: "2500", date: "2021-11-22", dashboard_id: 1, asset_id: 1)
t.save
t = Transaction.new(direction: "sell", asset_name: "bitcoin", quantity: "1", price: "3000", date: "2021-11-23", dashboard_id: 1, asset_id: 1)
t.save
puts "✅ Databse seeded!"
