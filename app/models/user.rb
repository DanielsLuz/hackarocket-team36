class User
  include Mongoid::Document
  include Mongoid::Paranoia

  field :phone, type: String
end
