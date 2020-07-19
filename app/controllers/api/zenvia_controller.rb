module Api
  class ZenviaController < Api::ApiController
    def message_received
      Zenvia::BaseMessageHandler.new(event: params).call
      head :ok
    end

    def order_received
      Zenvia::OrderMessageHandler.new.call(*message_params.values)
    end

    def update_delivery_address
      Zenvia::DeliveryAddressMessageHandler.new.call(*message_params.values)
    end

    def create_user
      User.find_or_create_by(phone_number: message_params[:from])
    end

    private

    def message_params
      params.permit(:from, :message_text)
    end
  end
end
