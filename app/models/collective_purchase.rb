class CollectivePurchase
  include Mongoid::Document

  has_many :orders

end
