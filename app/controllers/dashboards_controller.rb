class DashboardsController < ApplicationController
  def index
    @dashboards = Dashboard.where(user_id: current_user)
  end

  def show
    @dashboard = Dashboard.find(params[:id])
    @assets = @dashboard.define_assets
    # @total_value = @dashboard.total_value(@assets)
    # @total_pnl = @dashboard.total_pnl(@assets)
  end

  def new
    @dashboard = Dashboard.new
  end

  def create
    @dashboard = Dashboard.new(dashboard_params)
    @dashboard.user = current_user
    if @dashboard.save
      redirect_to dashboards_path
    else
      render :new
    end
  end

  def edit
    @dashboard = Dashboard.find(params[:id])
  end

  def destroy
    @dashboard = Dashboard.find(params[:id])
    @dashboard.delete
    redirect_to dashboards_path
  end

  def update
    @dashboard = Dashboard.find(params[:id])
    @dashboard.update(name: dashboard_params[:name])
    redirect_to dashboards_path
  end

  private

  def dashboard_params
    params.require(:dashboard).permit(:name)
  end
end
