class Transaction < ApplicationRecord
  belongs_to :dashboard
  validates :direction, presence: true
  validates :dashboard_id, presence: true
  validates :asset_id, presence: true
  validates :direction, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :asset_name, presence: true
  validates :date, presence: true
  scope :date_range, -> { where("date > params[:transaction][:date_from] AND date < params[:transaction][:date_to]") }
end
