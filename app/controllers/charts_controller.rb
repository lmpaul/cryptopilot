class ChartsController < ApplicationController
  def pie
    @dashboard = Dashboard.find(params[:dashboard_id])
    render json: @dashboard.pie
  end

  def values
    @dashboard = Dashboard.find(params[:dashboard_id])
    render json: @dashboard.values
  end

  def sparkline
    @dashboard = Dashboard.find(params[:dashboard_id])
    @keys = @dashboard.define_assets.last.keys
    @prices = {}
    @keys.each do |key|
      history = PriceHistory.where("id_name = '#{key}'").distinct
      @prices[key] = history.map do |value|
        [value.date, value.price.round(2)]
      end
    end
    keys = @prices.keys
    keys.each do |key|
      @prices[key] = @prices[key].sort { |a, b| a[0] <=> b[0] }
    end
    render json: @prices
  end
end
