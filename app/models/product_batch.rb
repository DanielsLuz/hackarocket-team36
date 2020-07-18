class ProductBatch
  include Mongoid::Document

  field :batch_size, type: Integer
  field :orders, type: Array

  def add_order(new_order)
    orders << new_order
    if current_batch_size >= batch_size
      CollectivePurchase.create!(orders: orders)
    end
  end

  def current_batch_size
    orders.sum(&:quantity)
  end

end
