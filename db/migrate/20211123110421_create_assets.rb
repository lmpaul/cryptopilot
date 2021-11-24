class CreateAssets < ActiveRecord::Migration[6.0]
  def change
    create_table :assets do |t|
      t.string :id_name
      t.integer :rank
      t.string :name
      t.string :symbol
      t.string :image

      t.timestamps
    end
  end
end
