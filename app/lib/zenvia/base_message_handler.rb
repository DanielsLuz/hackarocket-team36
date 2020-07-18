module Zenvia
  class BaseMessageHandler
    def call(event:)
      return unless whatsapp_incoming_message_event?(event)

      message_event = params.dig(:message)
      contents = message_event.dig(:contents)

      if delivery_address_message?(message_event)
        Zenvia::DeliveryAddressMessageHandler.new.call(
          address_message: message_event[:contents].last,
          phone_number: message_event[:from]
        )
      elsif ordering_request_message?(message_event)
        MessageConsumer.process(params)
      end
    end

    private

    def whatsapp_incoming_message_event?(event)
      event[:direction] == 'IN' &&
        event[:type] == 'MESSAGE' &&
        event[:channel] == 'whatsapp'
    end

    def delivery_address_message?(message_event)
      false
    end

    def ordering_request_message?(message_event)
      false
    end
  end
end
