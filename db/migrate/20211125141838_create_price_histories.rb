class CreatePriceHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :price_histories do |t|
      t.string :id_name
      t.date :date
      t.float :price
      t.timestamps
    end
  end
end
