module Zenvia
  class BaseMessageHandler
    def call(event:)
      return unless whatsapp_incoming_message_event?(event)

      message = params.dig(:message)
      contents = message.dig(:contents)

      if delivery_address_message?(message)
        Zenvia::DeliveryAddressMessageHandler.new.call(
          address_message: message[:contents].last,
          phone_number: message[:from]
        )
      elsif ordering_request_message?(message)
        MessageConsumer.process(params)
      end
    end

    private

    def whatsapp_incoming_message_event?(event)
      event[:direction] == 'IN' &&
        event[:type] == 'MESSAGE' &&
        event[:channel] == 'whatsapp'
    end

    def delivery_address_message?(message)
      false
    end

    def ordering_request_message?(message)
      false
    end
  end
end
