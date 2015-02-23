class Api::TagController < ApplicationController

  protect_from_forgery with: :null_session
  rescue_from ActionController::UnknownFormat, with: :raise_bad_format
  before_action :api_authenticate
  respond_to :json, :xml

  def index
    tag = Tag.all

    if offset_params.present?
      tag = Tag.limit(@limit).offset(@offset)
    end

    if tag.empty?
      @error = ErrorMessage.new('There is no tags to be found', 'There is no tags to be found')
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

  def create
    tag = Tag.new(tag_params)

    if tag.save
      respond_with tag, location: url_for([:api, tag]),status: :ok
    else
      @error = ErrorMessage.new("The tag was not found!", "Could not find resource. Are you using the right tag_id?" )
      respond_with  @error, status: :not_found
    end

  end

  def update

    old_tag = Tag.find(params[:id])
    new_tag = Tag.new(tag_params)

    old_tag.name = new_tag.name

    old_tag.save
    render json: old_tag, status: :ok

  rescue ActiveRecord::RecordNotFound
    @error = ErrorMessage.new("The tag was not found!", "Could not find resource. Are you using the right tag id?" )
    render  json: @error, status: :not_found

  end

  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    render json: 'The tag has been deleted'

  rescue ActiveRecord::RecordNotFound
    @error = ErrorMessage.new("The tag was not found!", "Could not find resource. Are you using the right tag_id?" )
    render json: @error, status: :not_found
  end

  private
  def tag_params
    params.require(:tags).permit(:name)
  end

end
