class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :phone_number, type: String
  field :address, type: String
end
