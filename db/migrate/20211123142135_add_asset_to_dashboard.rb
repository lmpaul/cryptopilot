class AddAssetToDashboard < ActiveRecord::Migration[6.0]
  def change
    add_column :dashboards, :asset, :text
  end
end
