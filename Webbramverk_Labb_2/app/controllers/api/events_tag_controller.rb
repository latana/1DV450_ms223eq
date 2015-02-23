class Api::EventsTagController < ApplicationController

  rescue_from ActionController::UnknownFormat, with: :raise_bad_format
  before_action :api_authenticate

  def index

  end

  def show


  end

end
