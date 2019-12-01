class CustomerSerializer
  include FastJsonapi::ObjectSerializer

  attributes :first_name, :last_name

  has_many :invoices
end
