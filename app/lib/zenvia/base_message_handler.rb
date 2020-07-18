module Zenvia
  class BaseMessageHandler
    def call(event:)
      return unless whatsapp_incoming_message_event?(event)

      message_event = event.dig(:message)
      contents = message_event.dig(:contents)

      if delivery_address_message?(message_event)
        Zenvia::DeliveryAddressMessageHandler.new.call(
          address_message: message_event[:contents].last,
          phone_number: message_event[:from]
        )
      elsif ordering_request_message?(message_event)
        Zenvia::OrderMessageHandler.new.call(message_text, message_event[:from])
      end
    end

    private

    def whatsapp_incoming_message_event?(event)
      event[:direction] == 'IN' &&
        event[:type] == 'MESSAGE' &&
        event[:channel] == 'whatsapp'
    end

    def message_text
      @message_text ||=
        @payload[:message][:contents].find { |content| content[:type] == "text" }.dig(:text)
    end

    def delivery_address_message?(message_event)
      false
    end

    def ordering_request_message?(message_event)
      false
    end
  end
end
