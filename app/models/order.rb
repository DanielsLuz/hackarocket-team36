class Order
  include Mongoid::Document
  include Mongoid::Timestamps

  field :quantity, type: Integer
  field :product, type: String
  field :unit_price, type: Integer

  belongs_to :user
  belongs_to :collective_purchase, optional: true
  belongs_to :product_batch

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
end
