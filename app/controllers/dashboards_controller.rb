class DashboardsController < ApplicationController
  def index
    @dashboards = Dashboard.where(user_id: current_user)
  end
end
