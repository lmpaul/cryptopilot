class TransactionsController < ApplicationController
  # def index
  #   @transactions = Transaction.all
  # end

  def new
    @transaction = Transaction.new
    @dashboard = Dashboard.find(params[:dashboard_id])
  end

  def create
    @dashboard = Dashboard.find(params[:dashboard_id])
    @transaction = Transaction.new(direction: transaction_params[:direction],
                        dashboard_id: transaction_params[:dashboard],
                        asset_id: transaction_params[:asset_id],
                        price: transaction_params[:price],
                        quantity: transaction_params[:quantity],
                        asset_name: Asset.find(transaction_params[:asset_id].to_i).name,
                        date: transaction_params[:date])
    if @transaction.save
      redirect_to dashboard_path(@dashboard)
    else
      render :new
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:direction, :asset_id, :dashboard, :price, :quantity, :date)
  end
end
