module Zenvia
  class DeliveryAddressMessageHandler
    def call(address_message:, phone_number:)
      User.find_or_create_by(
        phone_number: phone_number
      ).update(address: address_message)
    end
  end
end
