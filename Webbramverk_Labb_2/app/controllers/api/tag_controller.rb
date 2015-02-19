class Api::TagController < ApplicationController

  rescue_from ActionController::UnknownFormat, with: :raise_bad_format
  before_action :api_authenticate
  respond_to :json, :xml

  def index
    tag = Tag.all

    if tag.empty?
      @error = ErrorMessage.new("There is no tags to be found", "There is no tags to be found" )
      respond_with  @error, status: :ok
    else
      respond_with tag, status: :ok
    end
  end

  def show
    tag_event = Tag.find(params[:id])
    event = tag_event.events
    respond_with event

  rescue ActiveRecord::RecordNotFound
    @error = ErrorMessage.new("The tag was not found!", "Could not find resource. Are you using the right tag_id?" )
    respond_with  @error, status: :not_found

  end

end
