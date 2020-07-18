class Order
  include Mongoid::Document

  field :quantity, type: Integer
  field :product, type: String

  belongs_to :user
  belongs_to :collective_purchase, optional: true
  belongs_to :product_batch
end
