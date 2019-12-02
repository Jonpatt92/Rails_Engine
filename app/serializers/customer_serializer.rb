class CustomerSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :first_name, :last_name

  attribute :created_at do |object|
    Date.parse(object.created_at.to_s)
  end

  attribute :updated_at do |object|
    Date.parse(object.updated_at.to_s)
  end

  has_many :invoices
end
