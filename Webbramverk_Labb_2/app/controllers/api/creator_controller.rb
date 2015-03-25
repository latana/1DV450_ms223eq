class Api::CreatorController < ApplicationController

  rescue_from ActionController::UnknownFormat, with: :raise_bad_format
  protect_from_forgery with: :null_session
  before_action :api_authenticate, only: [:index, :show]
  respond_to :json, :xml

  # Hämtar ut alla creators
  def index
    creator = Creator.all

    if creator.empty?
      @error = ErrorMessage.new("There is no creator to be found", "There is no creator to be found" )
      respond_with json: @error, status: :ok
    else
      respond_with creator, status: :ok
    end
  end

  # Visar events som en viss användare har skapat
  def show
    creator_event = Creator.find(params[:id])
    events_by_creator = creator_event.events
    respond_with events_by_creator, status: :ok

  rescue ActiveRecord::RecordNotFound
    @error = ErrorMessage.new("The creator was not found!", "Could not find resource. Are you using the right creator_id?" )
    respond_with json: @error, status: :not_found
  end

# kontrollerar creator namnet och lösenordet och skickar en token.
  def api_auth
    creator = Creator.find_by(user: request.headers[:user])
    if creator && creator.authenticate(request.headers[:password])
      render json: { auth_token: encodeJWT(creator) }
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

end
