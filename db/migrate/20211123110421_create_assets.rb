class CreateAssets < ActiveRecord::Migration[6.0]
  def change
    create_table :assets do |t|
      t.integer :coin_mcap_id
      t.integer :rank
      t.string :name
      t.string :symbol

      t.timestamps
    end
  end
end
