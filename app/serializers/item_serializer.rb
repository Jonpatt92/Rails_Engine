class ItemSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id
  belongs_to :merchant
  has_many :invoice_items
end
