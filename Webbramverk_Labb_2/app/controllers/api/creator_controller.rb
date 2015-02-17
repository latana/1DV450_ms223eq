class Api::CreatorController < ApplicationController

  respond_to :json, :xml

  def index
    creator = Creator.all
    respond_with creator
  end

  def show
    creator_event = Creator.find(params[:id])
    events = creator_event.events
    respond_with events
  end
end
