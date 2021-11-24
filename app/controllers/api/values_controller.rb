module Api
  class ValuesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
      @dashboard = Dashboard.find(params[:dashboard_id])
      render json: @dashboard.values
    end
  end
end
