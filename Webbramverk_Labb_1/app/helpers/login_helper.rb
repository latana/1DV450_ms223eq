module LoginHelper

  # Skapar en sessions kaka med användarens id
  def login(user)
    session[:user_id] = user.id
  end

  # Tar bort sessionen
  def logout
    session.delete(:user_id)
    @currentUser = nil
  end

  # retunerar den inloggade användaren, Om användaren inte är satt letas han upp i databasen
  def currentUser
    @currentUser ||= User.find_by(id: session[:user_id])
  end

  # kollar om användaren är satt
  def isLoggedIn?
    !currentUser.nil?
  end

  # Kontrollerar om användaren är inloggad. Annars tas han till loginsidan
  def checkUser
    unless isLoggedIn?
      flash[:danger] = 'please log in to enter this page'
      redirect_to login_path
    end
  end
end
