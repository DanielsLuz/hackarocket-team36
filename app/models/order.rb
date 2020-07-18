class Order
  include Mongoid::Document

  field :quantity, type: Integer
  belongs_to :user
  belongs_to :collective_purchase, optional: true
  belongs_to :product_batch
end
