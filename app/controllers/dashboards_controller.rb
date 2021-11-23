class DashboardsController < ApplicationController
  def index
    @dashboards = Dashboard.where(user_id: current_user)
  end

  def show
    @dashboard = Dashboard.find(params[:id])
    @dashboard.asset = @dashboard.define_assets
    @dashboard.save
    @assets = @dashboard.asset
    @total_value = @dashboard.total_value(@assets)
    @total_pnl = @dashboard.total_pnl(@assets)
  end
end
