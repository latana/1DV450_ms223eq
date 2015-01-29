class UsersController < ApplicationController
  def index

    @user = User.all

    #User.find(params[:user_id])
  end
end
