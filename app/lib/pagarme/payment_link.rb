module Pagarme
  class PaymentLink
    attr_reader :url, :errors

    def initialize(order)
      @total_amount = order.quantity * order.unit_price

      response = RestClient::Request.execute(
        url: "https://api.pagar.me/1/payment_links",
        method: :post,
        payload: {
          "api_key": ENV['PAGARME_API_KEY'],
          "amount": @total_amount,
          "items": [order.to_pagarme_object]
        }.to_json,
        headers: { "Content-Type": "application/json" }
      )

      @url = JSON.parse(response.body)["url"]
    rescue RestClient::BadRequest => error
      @errors = JSON.parse(error.response.body)
    end
  end
end
