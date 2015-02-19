class Api::EventController < ApplicationController

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
  position = Position.new(params[:long, :latt])
  position.save
  creator = Creator.new(params[:user])
  creator.save
  event = Event.new
  event.position = position
  event.creator = creator
  event.save
end

end