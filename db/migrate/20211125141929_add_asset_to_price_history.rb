class AddAssetToPriceHistory < ActiveRecord::Migration[6.0]
  def change
    add_reference :price_histories, :asset, null: false, foreign_key: true
  end
end
