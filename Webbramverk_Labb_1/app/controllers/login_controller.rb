class LoginController < ApplicationController

  # renderar ut login viewn om man inte är inloggad
  def index
    if isLoggedIn?
      redirect_to user_path(currentUser)
    end
  end

  # Tar in email (med små bokstäver) och password loggar in om uppgifterna är giltiga
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

  # Loggar ut om man är inloggad och gör systemet en redirect till loginsidan.
  def destroy
    if isLoggedIn?
      logout
      flash[:info] = "You are now logged out"
    end
    redirect_to root_url
  end
end