module Api
  class ZenviaController < Api::ApiController
    def message_received
      Zenvia::BaseMessageHandler.new(event: params).call
      head :ok
    end

    def order_received
      Zenvia::OrderMessageHandler.new.call(*message_params)
    end

    private

    def message_params
      params.permit(:from, :message_text).values
    end
  end
end
