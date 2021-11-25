class Asset < ApplicationRecord
  validates :id_name, presence: true
  validates :rank, presence: true
  validates :name, presence: true
  validates :symbol, presence: true
  validates :image, presence: true
  has_many :price_histories

  # include PgSearch::Model
  # pg_search_scope :search_by_name_and_symbol, against: [ :name, :symbol ], using: { tsearch: { prefix: true } }
end
