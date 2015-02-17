class RegisterController < ApplicationController

  def new
# Om man är inloggad skickas man till sin user page
    if isLoggedIn?
      redirect_to user_path(currentUser)
    end

    @user = User.new
  end

  # Skapar en användare och ger dem en api nyckel
  def create
    @user = User.new(user_params)
    key = Key.new
    key.key = SecureRandom.hex

    if @user.save
      key.user = @user
      key.save
      flash[:success] = 'The registration was a success! You are welcome to login now'
      redirect_to root_path
    else
      flash.now[:danger] = 'Email/password is invalid'
      render 'new'
    end
  end

  # Metod som får innehållet från formuläret
  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
