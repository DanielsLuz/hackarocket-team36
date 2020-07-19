class CollectivePurchase
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :orders

  after_create :alert_success_order

  def alert_success_order
    orders.each do |order|
      Zenvia::Api::SendWhatsappMessage.call(
        order.phone_number,
        "✔️ Sua compra coletiva de #{order.product_name} já tem pedidos suficientes.\nAgora só precisamos" \
        " receber os pagamentos para mandar o pedido ao fornecedor.\nAcesse o" \
        " link para fazer o pagamento do seu pedido.\n\n #{Pagarme::PaymentLink.new(order).url}"
      )
    end
  end
end
