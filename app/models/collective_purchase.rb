class CollectivePurchase
  include Mongoid::Document

  field :orders, type: Array
end
