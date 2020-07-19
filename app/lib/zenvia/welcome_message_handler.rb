module Zenvia
  class WelcomeMessageHandler
    def call(phone_number:)
      User.create(phone_number: phone_number)
    end
  end
end
