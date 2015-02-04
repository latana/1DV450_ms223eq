class UsersController < ApplicationController

  # Endast en inloggad får använda sig av metoden show
  before_action :checkUser, only: [:show]

  # Endast den rätta användaren får använda sig av metoden show och destroy
  before_action :correctUser, only: [:show, :destroy]

  # Tar in alla användarna för admin login
  # Tar in den användaren och nyckeln som kommer med som parametrar
  def show

    @allkeys = Key.all
    @key = Key.find_by_user_id(params[:id])
    @user = User.find(params[:id])
  end

  # Tar bort den valda nyckeln
  def destroy

    if Key.find_by_user_id(params[:id]).destroy

      flash[:success] = 'The key has been deleted'
      redirect_to user_path
    else
      flash[:danger] = 'Somthing went horribly wrong and the key was not deleted'
      render 'show'
    end
  end

  # Skapar en ny nyckel åt användaren
  def create

    key = Key.new
    key.key = SecureRandom.hex
    key.user = User.find(params[:id])

    if key.save
      flash[:success] = 'Your key has been regenerated'
      redirect_to user_path(currentUser)
    else
      flash.now[:danger] = 'somthing went wrong'
      render 'show'
    end
  end

  # Kontrollerar ifall användaren är giltig annars skickas användaren tillbaka till sin egna sida
  def correctUser
    @user = User.find(params[:id])
    redirect_to user_path(currentUser) unless @user == currentUser || currentUser.admin?
  end
end
