class ProductBatch
  include Mongoid::Document

  field :batch_size, type: Integer
  field :current_batch_size, type: Integer
end
