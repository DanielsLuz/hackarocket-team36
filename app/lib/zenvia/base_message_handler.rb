module Zenvia
  class BaseMessageHandler
    def call(event:)
      return unless whatsapp_incoming_message_event?(event)

      @message_event = event.dig(:message)
      @contents = message_event.dig(:contents)

      if delivery_address_message?
        Zenvia::DeliveryAddressMessageHandler.new.call(
          phone_number: message_event[:from],
          address_message: message_text
        )
      elsif ordering_request_message?
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
      @message_text ||= @contents.find { |content| content[:type] == "text" }.dig(:text)
    end

    def delivery_address_message?
      false
    end

    def ordering_request_message?
      false
    end
  end
end
