module Zenvia
  class SendWhatsappMessage
    def call(number, message)
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
      JSON.parse(error.response.body)
    end
  end
end
