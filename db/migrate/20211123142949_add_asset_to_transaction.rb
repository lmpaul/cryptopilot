class AddAssetToTransaction < ActiveRecord::Migration[6.0]
  def change
    add_reference :transactions, :asset, null: false, foreign_key: true
  end
end
