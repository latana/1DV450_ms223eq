class LoginController < ApplicationController

  def index
    # går till login viewn
  end

  def create

    user = User.find_by(email: params[:login][:email].downcase)

    if user && user.authenticate(params[:login][:password])

      login user

      redirect_to user
    else

      flash.now[:danger] = 'Invalid Email/password'
      render 'index'
    end
  end

  def destroy
    logout
    flash[:info] = "You are now logged out"
    redirect_to root_url
  end
end