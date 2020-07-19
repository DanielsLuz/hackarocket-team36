module Api
  class PagarmeController < Api::ApiController
    def update
      order = Order.find(id: order_id)
      order.update!(status: "paid")
      Zenvia::Api::SendWhatsappMessage.call(
        order.user.phone_number,
        "Obrigado pelo seu pedido! Quando tiver outro pedido ou qualquer dúvida, é só falar com a gente."
      )
      head :ok
    end

    private
    def order_id
      params["order"]["items"]["0"]["id"]
    end
  end
end
