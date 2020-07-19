class ProductBatch
  include Mongoid::Document

  field :batch_size, type: Integer
  field :product, type: String
  field :complete, type: Boolean, default: false
  field :unit_price, type: Integer

  has_many :orders

  default_scope { where(complete: false) }

  def self.basket_by(product)
    where(product: product).last
  end

  def add_order(new_order)
    orders << new_order
    new_order.update(unit_price: unit_price)
    if current_batch_size >= batch_size
      CollectivePurchase.create!(orders: orders)
      self.complete = true

      initialize_new_batch
    end
    save!
  end

  def current_batch_size
    orders.sum(&:quantity)
  end

  def initialize_new_batch
    self.class.create!(product: product, batch_size: batch_size)
  end
end
