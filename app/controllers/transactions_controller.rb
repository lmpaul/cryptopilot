class TransactionsController < ApplicationController
  def new
    @dashboard = Dashboard.find(params[:dashboard_id])
    @transaction = Transaction.new
  end

  def create
    @dashboard = Dashboard.find(transaction_params[:dashboard])
    @transaction = Transaction.new(direction: transaction_params[:direction],
                         dashboard_id: @dashboard.id,
                         user_id: current_user.id,
                         asset_id: transaction_params[:asset_id],
                         price: transaction_params[:price],
                         quantity: transaction_params[:quantity],
                         asset_name: Asset.find(transaction_params[:asset_id]),
                         date: Date.today)
    if @transaction.save
      redirect_to dashboard_path(@dashboard)
    else
      render :new
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:direction, :asset_id, :dashboard, :price)
  end
end
