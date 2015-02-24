class Api::EventController < ApplicationController

  protect_from_forgery with: :null_session
  rescue_from ActionController::UnknownFormat, with: :raise_bad_format
  before_action :api_authenticate
  before_action :user_authenticate, only: [:create]
  respond_to :json, :xml

  # Hämtar ut alla events och skickar i datumsordning
  def index
    event = Event.all.order(created_at: :desc)

    if offset_params.present?
      event = Event.limit(@limit).offset(@offset).order(created_at: :desc)
    end
    if params[:query].present?
      event = Event.where('description LIKE ?', "%#{params[:query]}%")
    end
    if event.empty?
      @error = ErrorMessage.new('There is no event to be found', 'There is no event to be found')
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
    event.creator_id = @creator_id
    tag = Tag.new(tag_params)

    if Tag.find_by_name(tag.name).present?
      tag = Tag.find_by_name(tag.name)
    end
    event.tags << tag

    if event.save && tag.save
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

  # This method is using the geocoder and helps with searching near a specific position
  def nearby

    # Check the parameters
    if params[:long].present? && params[:latt].present?

      # using the parameters and offset/limit
      position = Position.near([params[:long].to_f, params[:latt].to_f], 20).limit(@limit).offset(@offset)

      respond_with position.map(&:events), status: :ok
    else

      error = ErrorMessage.new("Could not find any resources. Bad parameters?", "Could not find any team!" )
      render json: error, status: :bad_request # just json in this example
    end

  end

  private
  def event_params
    params.require(:event).permit(:position_id, :description)
  end

  private
  def tag_params
    params.require(:tags).permit(:name)
  end

end