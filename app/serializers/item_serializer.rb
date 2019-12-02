class ItemSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name, :description, :unit_price, :merchant_id

  attribute :created_at do |object|
    Date.parse(object.created_at.to_s)
  end

  attribute :updated_at do |object|
    Date.parse(object.updated_at.to_s)
  end

  belongs_to :merchant
  has_many :invoice_items
end
