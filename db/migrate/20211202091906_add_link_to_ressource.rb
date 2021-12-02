class AddLinkToRessource < ActiveRecord::Migration[6.0]
  def change
    add_column :ressources, :link, :string
  end
end
