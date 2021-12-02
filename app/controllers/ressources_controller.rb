class RessourcesController < ApplicationController
  def index
    @ressources = Ressource.where(user_id: current_user)
    @vote = Vote.new
  end

  def exchanges
    @ressources = Ressource.where(category: "Exchange")
    @ressources = @ressources.sort_by{ |ressource| -ressource.votes.length }
    @vote = Vote.new
  end

  def wallets
    @ressources = Ressource.where(category: "Wallet")
    @ressources = @ressources.sort_by{ |ressource| -ressource.votes.length }
    @vote = Vote.new
  end

  def youtube
    @ressources = Ressource.where(category: "Youtube")
    @ressources = @ressources.sort_by{ |ressource| -ressource.votes.length }
    @vote = Vote.new
  end

  private

  def ressource_params
    params.require(:ressource).permit(:name, :description)
  end


end
