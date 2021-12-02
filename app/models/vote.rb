class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :ressource
  validates :user, uniqueness: { scope: :ressource }
end
