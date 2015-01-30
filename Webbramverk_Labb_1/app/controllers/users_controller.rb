class UsersController < ApplicationController

  before_action :checkUser, only: [:index]

  def index
    #@user = User.find_by(email: params)
  end

  def show
    @user = User.find(params[:id])
    @key = Key.find_by_user_id(params[:id])
  end

  def destroy

    Key.find(params[:id]).destroy
    flash[:success] = "Din nyckel är DÖD!!!"
    render 'show'
  end
end
