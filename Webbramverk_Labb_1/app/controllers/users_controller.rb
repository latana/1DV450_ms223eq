class UsersController < ApplicationController

  before_action :checkUser, only: [:show]
  before_action :correctUser, only: [:show, :destroy]

  def show
    @allkeys = Key.all
    @key = Key.find_by_user_id(params[:id])
  end

  def destroy

    if Key.find_by_user_id(params[:id]).destroy

      flash[:success] = 'The key has been deleted'
      redirect_to user_path
    else
      flash[:danger] = 'Somthing went horribly wrong and the key was not deleted'
      render 'show'
    end

  end

  def correctUser
    @user = User.find(params[:id])
    redirect_to user_path(currentUser) unless @user == currentUser || currentUser.admin?
  end

end
