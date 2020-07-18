module Api
  class ZenviaController < Api::ApiController
    def message_received
      Zenvia::BaseMessageHandler.new.call(event: params)
      head :ok
    end
  end
end
