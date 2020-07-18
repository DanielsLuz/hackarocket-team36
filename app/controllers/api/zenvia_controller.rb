module Api
  class ZenviaController < Api::ApiController
    def message_received
      if params[:direction] == 'IN'
        message = params.dig(:message)

        if message
          Zenvia::DeliveryAddressMessageHandler.new.call(
            address_message: message[:contents].last,
            phone_number: message[:from]
          )

          MessageConsumer.process(params)
        end
      end
      head :ok
    end
  end
end
