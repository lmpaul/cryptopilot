class TransactionsController < ApplicationController
  def index
    @dashboard = Dashboard.find(params[:dashboard_id])
    if params[:transaction]
      @transactions = Transaction.where("date > :from AND date < :to", { from: params[:transaction][:date_from].to_date, to: params[:transaction][:date_to].to_date })
      @transactions = @transactions.where(asset_id: (params[:transaction][:asset_id]).to_i)
      @transactions = @transactions.where(dashboard_id: @dashboard.id)
    else
    @transactions = Transaction.where(dashboard_id: @dashboard.id)
    end
  end

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

  def edit
    @transaction = Transaction.find(params[:id])
    @dashboard = Dashboard.find(params[:dashboard_id])
  end

  def update
    @transaction = Transaction.find(params[:id])
    @transaction.update(transaction_params)
    @dashboard = Dashboard.find(params[:dashboard_id])

    redirect_to dashboard_transactions_path(@dashboard)
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy
    @dashboard = Dashboard.find(params[:dashboard_id])

    redirect_to dashboard_transactions_path(@dashboard)
  end

  private

  def transaction_params
    params.require(:transaction).permit(:direction, :asset_id, :dashboard, :price, :quantity, :date)
  end
end
