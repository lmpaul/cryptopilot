class ChartsController < ApplicationController

  def values
    @dashboard = Dashboard.find(params[:dashboard_id])

    render json: @dashboard.charts
  end

  def pie
    @dashboard = Dashboard.find(params[:dashboard_id])

    render json: @dashboard.pie
  end

  def sparkline
    @dashboard = Dashboard.find(params[:dashboard_id])

    render json: @dashboard.sparklines
  end
end
