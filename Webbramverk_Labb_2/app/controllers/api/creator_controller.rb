class Api::CreatorController < ApplicationController

  rescue_from ActionController::UnknownFormat, with: :raise_bad_format
  before_action :api_authenticate
  respond_to :json, :xml

  def index
    creator = Creator.all

    if tag.empty?
      @error = ErrorMessage.new("There is no creator to be found", "There is no creator to be found" )
      respond_with  @error, status: :ok
    else
      respond_with creator, status: :ok
    end
  end

  def show
    creator_event = Creator.find(params[:id])
    events_by_creator = creator_event.events
    respond_with events_by_creator, status: :ok

  rescue ActiveRecord::RecordNotFound
    @error = ErrorMessage.new("The creator was not found!", "Could not find resource. Are you using the right creator_id?" )
    respond_with  @error, status: :not_found
  end
end
