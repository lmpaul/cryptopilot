class ChartsController < ApplicationController

  def values
    @dashboard = Dashboard.find(params[:dashboard_id])
    hash = {
      value: @dashboard.charts[0],
      pie: @dashboard.charts[1]
    }
    render json: hash
  end

  def sparkline
    @dashboard = Dashboard.find(params[:dashboard_id])

    render json: @dashboard.sparklines
  end
end
