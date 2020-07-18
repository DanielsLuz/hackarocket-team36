module Api
  class ZenviaController < Api::ApiController
    def message_received
      Zenvia::BaseMessageHandler.new.call(message_event: params)
      head :ok
    end
  end
end
