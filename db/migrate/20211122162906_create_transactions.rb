class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :direction
      t.string :asset_name
      t.float :quantity
      t.float :price
      t.date :date

      t.timestamps
    end
  end
end
