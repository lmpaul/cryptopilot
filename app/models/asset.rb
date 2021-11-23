class Asset < ApplicationRecord
  validates :coin_mcap_id, presence: true
  validates :rank, presence: true
  validates :name, presence: true
  validates :symbol, presence: true
end
