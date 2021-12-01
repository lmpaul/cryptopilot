class RessourcesController < ApplicationController
  def index
    @ressources = Ressource.where(user_id: current_user)
  end

  def exchanges
    @ressources = Ressource.where(category: "Exchange")
  end

  def wallets
    @ressources = Ressource.where(category: "Wallet")
  end

  def youtube
    @ressources = Ressource.where(category: "Youtube")
  end

  def edit
    @ressource = Ressource.find(params[:id])
  end

  def update
    @ressource = Ressource.find(params[:id])
    @ressource.update(ressource_params)
    redirect_to ressources_path
  end

  private

  def ressource_params
    params.require(:ressource).permit(:name, :description)
  end


end
