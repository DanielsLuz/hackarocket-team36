module Zenvia
  class BaseMessageHandler
    MESSAGE_PATTERNS = {
      MAKE_ORDER: Regexp.union(
        [/.*fazer.*pedido.*/i, /pedidos/i, /compras/i]
      )
    }.freeze

    def initialize(event:)
      @event = event
    end

    def call
      return unless whatsapp_incoming_message_event?

      if first_user_message?
        Zenvia::WelcomeMessageHandler.new.call(
          phone_number: message_event[:from]
        )
      elsif delivery_address_message?
        Zenvia::DeliveryAddressMessageHandler.new.call(
          phone_number: message_event[:from],
          address_message: message_text
        )
      elsif ordering_request_message?
        Zenvia::OrderMessageHandler.new.call(message_event[:from], message_text)
      end
    end

    private

    def whatsapp_incoming_message_event?
      @event[:direction] == 'IN' &&
        @event[:type] == 'MESSAGE' &&
        @event[:channel] == 'whatsapp'
    end

    def message_event
      @message_event ||= @event.dig(:message)
    end

    def contents
      @contents ||= message_event.dig(:contents)
    end

    def message_text
      @message_text ||= contents.find { |content| content[:type] == "text" }.dig(:text)
    end

    def first_user_message?
      User.find_by(phone_number: message_event[:from]).present?
    end

    def delivery_address_message?
      message_text.match(/(.*),(.*),(.*)/)
    end

    def ordering_request_message?
      MESSAGE_PATTERNS[:MAKE_ORDER].match(message_text)
    end
  end
end
