class Api::EventController < ApplicationController

rescue_from ActionController::UnknownFormat, with: :raise_bad_format

respond_to :json, :xml

# Hämtar ut alla events och skickar i datumsordning
def index
  event = Event.order(created_at: :desc)
  respond_with event
end

def show
  event = Event.find_by_id(params[:id])
  respond_with event
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

private

def raise_bad_format
  @error = ErrorMessage.new("The API does not support the requested format", "There was a request. Contact the developer!" )

  render json: @error, status: :bad_request
end

end

class ErrorMessage

  def initialize(dev_mess, usr_mess)

    @message_for_developer = dev_mess
    @message_for_user = usr_mess
  end


  def to_xml(options={})
    str = "<error>"
    str += "  <message_for_developer>#{@message_for_developer}</developerMessage>"
    str += "  <message_for_developer>#{@message_for_user}</userMessage>"
    str += "</error>"
  end
end