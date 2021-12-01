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

puts "👨🏻‍💻 User created"

r = Ressource.new(name: "Binance", description: "First exchange by volume in the world", nb_up_votes: 10, user_id: 1, category: "Exchange")
r.save

r = Ressource.new(name: "MetaMask", description: "Most famous wallet for the  Ethereum network", nb_up_votes: 5, user_id: 1, category: "Wallet")
r.save

r = Ressource.new(name: "Hasheur", description: "Vulgarisation Crypto", nb_up_votes: 7, user_id: 1, category: "YouTube")
r.save

puts "📚 Resources created"

puts "✅ Databse seeded!"
