module Zenvia
  class BaseMessageHandler
    def call(message_event:)
      return unless whatsapp_incoming_message_event?(message_event)

      message = params.dig(:message)

      if message
        Zenvia::DeliveryAddressMessageHandler.new.call(
          address_message: message[:contents].last,
          phone_number: message[:from]
        )
        MessageConsumer.process(params)
      end
    end

    private

    def whatsapp_incoming_message_event?(message_event)
      message_event[:direction] == 'IN' &&
        message_event[:type] == 'MESSAGE' &&
        message_event[:channel] == 'whatsapp'
    end
  end
end
