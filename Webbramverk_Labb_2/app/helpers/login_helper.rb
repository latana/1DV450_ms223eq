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

  ### Labration 2

  def api_authenticate
    if request.headers['apikey'].present?

      auth_header = request.headers['apikey'].split(' ').last

      key = Key.find_by_key(auth_header)

      if key == nil || key.key != auth_header
        render json: { error: 'The provided token wasn´t correct' }, status: :bad_request
      end
    else
      render json: { error: 'Need to include the Authorization header' }, status: :forbidden
    end
  end

  def user_authenticate
    if request.headers['userkey'].present?

      auth_header = request.headers['userkey'].split(' ').last

      @token_payload = decodeJWT auth_header.strip
      if @token_payload
        @creator_id = @token_payload[0]['creator_id']
      end
    else
      render json: { error: 'Need to include the Authorization header' }, status: :forbidden # The header isn´t present
    end
  end

  def encodeJWT(creator, exp=2.hours.from_now)

    payload = { creator_id: creator.id }
    payload[:exp] = exp.to_i

    # Encode the payload whit the application secret, and a more advanced hash method (creates header with JWT gem)
    JWT.encode( payload, Rails.application.secrets.secret_key_base, "HS512")

  end

  # When we get a call we have to decode it - Returns the payload if good otherwise false
  def decodeJWT(token)
    # puts token
    payload = JWT.decode(token, Rails.application.secrets.secret_key_base, "HS512")
    # puts payload
    if payload[0]["exp"] >= Time.now.to_i
      payload
    else
      puts "time fucked up"
      false
    end
      # catch the error if token is wrong
  rescue => error
    puts error
    nil
  end

  end
