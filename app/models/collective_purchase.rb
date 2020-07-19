class CollectivePurchase
  include Mongoid::Document

  has_many :orders

  after_create :alert_success_order

  def alert_success_order
    orders.each do |order|
      Zenvia::Api::SendWhatsappMessage.call(
        order.phone_number,
        "Seu pedido de #{order.product} coletivo já está em andamento.
         Estamos te enviado o link para pagamento"
      )
    end
  end
end
