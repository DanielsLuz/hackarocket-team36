module Zenvia
  class DeliveryAddressMessageHandler
    def call(phone_number, address_message)
      User.find_or_create_by(
        phone_number: phone_number
      ).update(address: address_message)
    end
  end
end
