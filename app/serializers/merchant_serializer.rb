class MerchantSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name
  has_many :items
  has_many :invoices
end
