class Api::EventController < ApplicationController

  protect_from_forgery with: :null_session
  rescue_from ActionController::UnknownFormat, with: :raise_bad_format
  before_action :api_authenticate
  respond_to :json, :xml

  # Hämtar ut alla events och skickar i datumsordning
  def index
    event = Event.order(created_at: :desc)

    if event.empty?
      @error = ErrorMessage.new("There is no event to be found", "There is no event to be found" )
      respond_with  @error, status: :ok
    else
      respond_with event, status: :ok
    end
  end

  def show
    event = Event.find(params[:id])
    respond_with event

  rescue ActiveRecord::RecordNotFound
    @error = ErrorMessage.new("The event was not found!", "Could not find resource. Are you using the right event_id?" )
    respond_with  @error, status: :not_found

  end

  def create
    event = Event.new(event_params)

    if event.save
      respond_with event, location: url_for([:api, event]),status: :ok
    else
      respond_with 'Somthing went wrong.', status: :not_found
    end

    rescue ActiveRecord::RecordInvalid
      @error = ErrorMessage.new("The event was not found!", "Could not find resource. Are you using the right event_id?" )
      respond_with  @error, status: :bad_request

  end

  def update

    old_event = Event.find(params[:id])
    new_event = Event.new(event_params)

    old_event.position_id = new_event.position_id
    old_event.description = new_event.description

    old_event.save
      render json: old_event, status: :ok

  rescue ActiveRecord::RecordNotFound
    @error = ErrorMessage.new("The event was not found!", "Could not find resource. Are you using the right event_id?" )
    render  json: @error, status: :not_found

  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    render json: 'The event has been deleted'

    rescue ActiveRecord::RecordNotFound
      @error = ErrorMessage.new("The event was not found!", "Could not find resource. Are you using the right event_id?" )
      render json: @error, status: :not_found
  end

  private
  def event_params
    params.require(:event).permit(:position_id, :creator_id, :description)
  end

end