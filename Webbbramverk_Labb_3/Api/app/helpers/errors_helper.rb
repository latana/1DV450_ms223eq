module ErrorsHelper

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

  def raise_bad_format
    @error = ErrorMessage.new("The API does not support the requested format", "There was a request. Contact the developer!" )
    render json: @error, status: :bad_request
  end

end
