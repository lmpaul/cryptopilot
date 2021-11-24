class Asset < ApplicationRecord
  validates :id_name, presence: true
  validates :rank, presence: true
  validates :name, presence: true
  validates :symbol, presence: true
  validates :image, presence: true
end
