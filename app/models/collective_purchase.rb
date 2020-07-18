class CollectivePurchase
  include Mongoid::Document

  has_many :orders

  def alert_success_order
    orders.map(&:user).map(&:phone_number).each do |cellphone|
      Zenvia::SendWhatsappMessage.call(
        cellphone,
        "Seu pedido de atacado foi construido. Estamos te enviado o link para pagamento"
      )
    end
  end
end
