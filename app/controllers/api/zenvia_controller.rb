module Api
  class ZenviaController < Api::ApiController
    def order_received
      Zenvia::OrderMessageHandler.new.call(*message_params.values)
    end

    def update_delivery_address
      Zenvia::DeliveryAddressMessageHandler.new.call(*message_params.values)
    end

    def create_user
      User.find_or_create_by(phone_number: message_params[:from])
    end

    def check_address
      user = User.find_by(phone_number: message_params[:from])
      if user.address
        head :ok
      else
        head :not_found
      end
    end

    private

    def message_params
      params.permit(:from, :message_text)
    end
  end
end
