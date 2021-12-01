class AddCategoryToRessource < ActiveRecord::Migration[6.0]
  def change
    add_column :ressources, :category, :string
  end
end
