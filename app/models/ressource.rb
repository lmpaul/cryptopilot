class Ressource < ApplicationRecord
  has_one_attached :photo
  has_many :votes, dependent: :destroy
end
