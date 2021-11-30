class CreateRessources < ActiveRecord::Migration[6.0]
  def change
    create_table :ressources do |t|
      t.text :name
      t.text :description
      t.integer :nb_up_votes
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
