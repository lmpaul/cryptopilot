class CreateRessources < ActiveRecord::Migration[6.0]
  def change
    create_table :ressources do |t|
      t.text :name
      t.text :description
      t.text :category
    end
  end
end
