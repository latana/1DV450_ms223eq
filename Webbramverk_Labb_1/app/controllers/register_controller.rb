class RegisterController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    @user.key = 'test'
    #(0...5).map { (65 + rand(26)).chr }.join

    if @user.save
      redirect_to login_path
    else
      flash.now[:danger] = 'Email/password is invalid'
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
