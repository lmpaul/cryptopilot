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

u = User.new(email: "jeremy@cryptopilot.com", username: "Jeremy", password: "azerty")
u.save

u = User.new(email: "moussa@cryptopilot.com", username: "Moussa", password: "azerty")
u.save

u = User.new(email: "nathan@cryptopilot.com", username: "Nathan", password: "azerty")
u.save

u = User.new(email: "chris@cryptopilot.com", username: "Chris", password: "azerty")
u.save

u = User.new(email: "shimon@cryptopilot.com", username: "Shimon", password: "azerty")
u.save

u = User.new(email: "felix@cryptopilot.com", username: "Felix", password: "azerty")
u.save

u = User.new(email: "romain@cryptopilot.com", username: "Romain", password: "azerty")
u.save

u = User.new(email: "mathieu@cryptopilot.com", username: "Mathieu", password: "azerty")
u.save

u = User.new(email: "arnaud@cryptopilot.com", username: "Arnaud", password: "azerty")
u.save

u = User.new(email: "melanie@cryptopilot.com", username: "Melanie", password: "azerty")
u.save

u = User.new(email: "perrine@cryptopilot.com", username: "Perrine", password: "azerty")
u.save

u = User.new(email: "ahmed@cryptopilot.com", username: "Ahmed", password: "azerty")
u.save

u = User.new(email: "laurianne@cryptopilot.com", username: "Laurianne", password: "azerty")
u.save


puts "👨🏻‍💻 User created"

photo = URI.open("https://upload.wikimedia.org/wikipedia/commons/5/57/Binance_Logo.png")
r = Ressource.new(name: "Binance", description: "Beyond operating the world's leading cryptocurrency exchange, Binance spans an entire ecosystem.", category: "Exchange", link: "https://www.binance.com")
r.photo.attach(io: photo, filename: 'image', content_type: 'image/jpg')
r.save

photo = URI.open("https://cryptologos.cc/logos/ftx-token-ftt-logo.png")
r = Ressource.new(name: "FTX", description: "FTX Crypto Derivatives Exchange, built by traders, for traders", category: "Exchange", link: "https://www.ftx.com")
r.photo.attach(io: photo, filename: 'image', content_type: 'image/jpg')
r.save

photo = URI.open("https://cdn.bitpanda.com/media/blog/authors/bitpanda.jpg")
r = Ressource.new(name: "BitPanda", description: "Invest in what you believe in", category: "Exchange", link: "https://www.bitpanda.com")
r.photo.attach(io: photo, filename: 'image', content_type: 'image/jpg')
r.save

photo = URI.open("https://lh3.googleusercontent.com/proxy/adtVrdNUsFb_Z089kKebccwGWmJZG1EejWPCwQEtF6R9UlJZIQVOLBMkA2Pww2jQZzbTG88-AZGouAK43NXAu7xnlN5UUA5uURJYLMR6QR32DVDYyHitcss-JLE")
r = Ressource.new(name: "Coinbase", description: "Jump start your crypto portfolio", category: "Exchange", link: "https://www.coinbase.com")
r.photo.attach(io: photo, filename: 'image', content_type: 'image/jpg')
r.save

photo = URI.open("https://e7.pngegg.com/pngimages/465/269/png-clipart-kraken-bitcoin-cryptocurrency-exchange-ethereum-bitcoin-blue-text.png")
r = Ressource.new(name: "Kraken", description: "Kraken is a crypto exchange for everyone", category: "Exchange", link: "https://www.kraken.com")
r.photo.attach(io: photo, filename: 'image', content_type: 'image/jpg')
r.save

photo = URI.open("https://s2.coinmarketcap.com/static/img/coins/200x200/1776.png")
r = Ressource.new(name: "Crypto.com", description: "The World’s Fastest Growing Crypto App", category: "Exchange", link: "https://crypto.com/eea/")
r.photo.attach(io: photo, filename: 'image', content_type: 'image/jpg')
r.save

photo = URI.open("https://img2.freepng.fr/20181123/qfz/kisspng-swissborg-cryptocurrency-bitcoin-logo-ethereum-5bf7db4468b465.2925238615429701804289.jpg")
r = Ressource.new(name: "Swissborg", description: "Invest in cryptos the smart way.", category: "Exchange", link: "https://swissborg.com/")
r.photo.attach(io: photo, filename: 'image', content_type: 'image/jpg')
r.save

photo = URI.open("https://www.pngkit.com/png/detail/26-268992_metamask-metamask-wallet.png")
r = Ressource.new(name: "MetaMask", description: "A crypto wallet & gateway to blockchain apps", category: "Wallet", link: "https://www.metamask.io")
r.photo.attach(io: photo, filename: 'image', content_type: 'image/jpg')
r.save

photo = URI.open("https://ph-files.imgix.net/f05a61be-d906-4ad8-a68d-88f7c257574d.png?auto=format")
r = Ressource.new(name: "Phantom", description: "Turn your browser into a crypto wallet", category: "Wallet", link: "https://www.phantom.app")
r.photo.attach(io: photo, filename: 'image', content_type: 'image/jpg')
r.save

photo = URI.open("https://logowik.com/content/uploads/images/t_pegasus5022.jpg")
r = Ressource.new(name: "1inch Network", description: "The 1inch Network unites decentralized protocols whose synergy enables the most lucrative, fastest and protected operations in the DeFi space", category: "Wallet", link: "https://1inch.io/")
r.photo.attach(io: photo, filename: 'image', content_type: 'image/jpg')
r.save

photo = URI.open("https://airdrops.io/wp-content/uploads/2021/04/Maiar-logo.jpg")
r = Ressource.new(name: "Maiar Exchange", description: "Swap assets instantly, globally, inexpensively, automatically", category: "Wallet", link: "https://maiar.exchange/")
r.photo.attach(io: photo, filename: 'image', content_type: 'image/jpg')
r.save

photo = URI.open("https://cryptonaute.fr/wp-content/uploads/2021/01/polkadot-logo.png")
r = Ressource.new(name: "Polkadost.js", description: "A wallet built on the polkadot-js stack", category: "Wallet", link: "https://polkadot.js.org/")
r.photo.attach(io: photo, filename: 'image', content_type: 'image/jpg')
r.save

photo = URI.open("https://pbs.twimg.com/card_img/1464914764333731840/75jB25px?format=png&name=360x360")
r = Ressource.new(name: "Hasheur", description: "Vulgarisation Crypto", category: "Youtube", link: "https://www.youtube.com/c/Hasheur")
r.photo.attach(io: photo, filename: 'image', content_type: 'image/jpg')
r.save

photo = URI.open("https://yt3.ggpht.com/ytc/AKedOLTaedqRavlxp3hj1YGicidnpmfnZvzMWDiJRMpFJQ=s900-c-k-c0x00ffffff-no-rj")
r = Ressource.new(name: "CryptoMatrix", description: "La quotidienne française crypto", category: "Youtube", link: "https://www.youtube.com/channel/UCefQC4Y-X9MBRuYBKc2waiQ")
r.photo.attach(io: photo, filename: 'image', content_type: 'image/jpg')
r.save

photo = URI.open("https://bitcoin.fr/wp-content/uploads/2017/09/journal-du-coin.jpg")
r = Ressource.new(name: "Journal du Coin", description: "Découvrez toute l'actualité du Bitcoin et des cryptomonnaies, allant de l'explication de leur fonctionnement à des vidéos d'analyses techniques.", category: "Youtube", link: "https://www.youtube.com/channel/UC7qnB0XxzOEwWWn9Q6HPmCw")
r.photo.attach(io: photo, filename: 'image', content_type: 'image/jpg')
r.save

photo = URI.open("https://yt3.ggpht.com/ytc/AKedOLTJXB6wXVVQEgDn5hEy5VlA4wev04g2ErIMBTSW=s900-c-k-c0x00ffffff-no-rj")
r = Ressource.new(name: "Cryptoast", description: "Des vidéos pour comprendre, décrypter et suivre l’actualité du Bitcoin et des cryptomonnaies. ", category: "Youtube", link: "https://www.youtube.com/c/Cryptoast")
r.photo.attach(io: photo, filename: 'image', content_type: 'image/jpg')
r.save

puts "📚 Resources created"

puts "✅ Databse seeded!"
