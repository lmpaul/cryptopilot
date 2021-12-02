class VotesController < ApplicationController

  def create
    @vote = Vote.new(user_id: vote_params[:user_id], ressource_id: vote_params[:ressource_id])
    @vote.save!
    @ressource = @vote.ressource
    category = @ressource.category
    reload_page(category)
  end

  def destroy
    @vote = Vote.where(user_id: current_user.id, ressource_id: params[:ressource_id]).first
    @ressource = @vote.ressource
    @vote.destroy!
    category = @ressource.category
    reload_page(category)
  end

  private

  def vote_params
    params.require(:vote).permit(:user_id, :ressource_id)
  end

  def reload_page(category)
    if category == "Exchange"
      redirect_to exchanges_path
    elsif category == "Wallet"
      redirect_to wallets_path
    elsif category == "Youtube"
      redirect_to youtube_path
    end
  end
end
