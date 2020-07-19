module Zenvia
  module Api
    class SendWhatsappMessage
      def self.call(number, message)
        RestClient::Request.execute(
          url: "https://api.zenvia.com/v1/channels/whatsapp/messages",
          method: :post,
          payload: {
            "from": "actually-production",
            "to": number,
            "contents": [{ "type":"text","text": message }]
          }.to_json,
          headers: {
            "Content-Type": "application/json",
            "X-API-TOKEN": ENV['ZENVIA_API_TOKEN']
          }
        )
      rescue RestClient::BadRequest => error
        raise JSON.parse(error.response.body)
      rescue Exception => error
        puts error
      end
    end
  end
end
