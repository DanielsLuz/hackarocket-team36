class CollectivePurchase
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :orders

  after_create :alert_success_order

  def alert_success_order
    orders.map(&:user).map(&:phone_number).each do |cellphone|
      Zenvia::Api::SendWhatsappMessage.call(
        cellphone,
        "Seu pedido coletivo já está em andamento. Estamos te enviado o link para pagamento"
      )
    end
  end
end
