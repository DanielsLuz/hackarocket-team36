module Api
  class ZenviaController < Api::ApiController
    def message_received
      Zenvia::BaseMessageHandler.new(event: params).call
      head :ok
    end
  end
end
