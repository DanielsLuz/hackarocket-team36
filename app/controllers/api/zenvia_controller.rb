module Api
  class ZenviaController < Api::ApiController
    def message_received
      MessageConsumer.process(params)
    end
  end
end
