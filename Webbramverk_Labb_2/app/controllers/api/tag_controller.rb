class Api::TagController < ApplicationController

  respond_to :json, :xml

  def index
    tag = Tag.all
    respond_with tag
  end

  def show
    tag_event = Tag.find(params[:id])
    event = tag_event.events
    respond_with event
  end

end
