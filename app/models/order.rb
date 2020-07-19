class Order
  include Mongoid::Document
  include Mongoid::Timestamps

  field :quantity, type: Integer
  field :product, type: String
  field :unit_price, type: Integer
  field :status, type: String, default: ""

  belongs_to :user
  belongs_to :collective_purchase, optional: true
  belongs_to :product_batch, optional: true

  after_update :notify_update_status

  delegate :phone_number, to: :user

  def to_pagarme_object
    {
      "id": self.id.to_s,
      "title": self.product,
      "unit_price": self.unit_price,
      "quantity": self.quantity,
      # Discover what this attribute means
      "tangible": false
    }
  end

  def product_name
    {
      sugar: 'açúcar',
      oil: 'óleo',
      rice: 'arroz',
      beans: 'feijão',
      meat: 'carne'
    }[product.to_sym]
  end

  def notify_update_status
    if status == 'paid'
      Zenvia::Api::SendWhatsappMessage.call(
        user.phone_number,
        "Obrigado pelo seu pedido! Quando tiver outro pedido ou qualquer dúvida, é só falar com a gente."
      )
    end
  end
end
