class Transaction < ApplicationRecord
  belongs_to :dashboard
  # has_one :asset
  validates :price, presence: true
end
