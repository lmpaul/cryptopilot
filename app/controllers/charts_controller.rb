class ChartsController < ApplicationController
  def pie
    @dashboard = Dashboard.find(params[:dashboard_id])
    render json: @dashboard.pie
  end

  def values
    @dashboard = Dashboard.find(params[:dashboard_id])
    render json: @dashboard.values
  end
end
