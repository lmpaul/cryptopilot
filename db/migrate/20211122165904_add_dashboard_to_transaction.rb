class AddDashboardToTransaction < ActiveRecord::Migration[6.0]
  def change
    add_reference :transactions, :dashboard, null: false, foreign_key: true
  end
end
