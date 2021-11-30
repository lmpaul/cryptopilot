class RessourcesController < ApplicationController
  def index
    @ressources = Ressource.where(user_id: current_user)
  end

  def new
    @ressource = Ressource.new
  end

  def create
    @ressource = Ressource.new(ressource_params)
    @ressource.user = current_user
    if @ressource.save
      redirect_to ressources_path
    else
      render :new
    end
  end

  def show
    @ressources = Ressource.find(params[:id])
  end

  def edit
    @ressource = Ressource.find(params[:id])
  end

  def update
    @ressource = Ressource.find(params[:id])
    @ressource.update(ressource_params)
    redirect_to ressources_path
  end

  def destroy
    @ressource = Ressource.find(params[:id])
    @ressource.destroy
    redirect_to ressources_path
  end

  private

  def ressource_params
    params.require(:ressource).permit(:name, :description)
  end


end
