class Order
  include Mongoid::Document

  field :quantity, type: Integer
  field :product, type: String

  belongs_to :user
  belongs_to :collective_purchase, optional: true
  belongs_to :product_batch

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
end
