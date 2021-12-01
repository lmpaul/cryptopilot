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

photo = URI.open("https://upload.wikimedia.org/wikipedia/commons/5/57/Binance_Logo.png")
r = Ressource.new(name: "Binance", description: "First exchange by volume in the world", nb_up_votes: 10, user_id: 1, category: "Exchange")
r.photo.attach(io: photo, filename: 'image', content_type: 'image/jpg')
r.save

photo = URI.open("https://cryptologos.cc/logos/ftx-token-ftt-logo.png")
r = Ressource.new(name: "FTX", description: "The world second exchange", nb_up_votes: 10, user_id: 1, category: "Exchange")
r.photo.attach(io: photo, filename: 'image', content_type: 'image/jpg')
r.save

photo = URI.open("https://cdn.bitpanda.com/media/blog/authors/bitpanda.jpg")
r = Ressource.new(name: "BitPanda", description: "European best exchange", nb_up_votes: 10, user_id: 1, category: "Exchange")
r.photo.attach(io: photo, filename: 'image', content_type: 'image/jpg')
r.save


photo = URI.open("https://www.pngkit.com/png/detail/26-268992_metamask-metamask-wallet.png")
r = Ressource.new(name: "MetaMask", description: "Most famous wallet for the Ethereum network", nb_up_votes: 5, user_id: 1, category: "Wallet")
r.photo.attach(io: photo, filename: 'image', content_type: 'image/jpg')
r.save

photo = URI.open("https://ph-files.imgix.net/f05a61be-d906-4ad8-a68d-88f7c257574d.png?auto=format")
r = Ressource.new(name: "Phantom", description: "Most famous wallet for the Solana network", nb_up_votes: 5, user_id: 1, category: "Wallet")
r.photo.attach(io: photo, filename: 'image', content_type: 'image/jpg')
r.save


photo = URI.open("https://pbs.twimg.com/card_img/1464914764333731840/75jB25px?format=png&name=360x360")
r = Ressource.new(name: "Hasheur", description: "Vulgarisation Crypto", nb_up_votes: 7, user_id: 1, category: "Youtube")
r.photo.attach(io: photo, filename: 'image', content_type: 'image/jpg')
r.save

photo = URI.open("https://yt3.ggpht.com/ytc/AKedOLTaedqRavlxp3hj1YGicidnpmfnZvzMWDiJRMpFJQ=s900-c-k-c0x00ffffff-no-rj")
r = Ressource.new(name: "CryptoMatrix", description: "La quotidienne française crypto", nb_up_votes: 7, user_id: 1, category: "Youtube")
r.photo.attach(io: photo, filename: 'image', content_type: 'image/jpg')
r.save

puts "📚 Resources created"

puts "✅ Databse seeded!"
