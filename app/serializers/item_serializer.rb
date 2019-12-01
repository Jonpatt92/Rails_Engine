class ItemSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :description, :unit_price, :merchant_id
  belongs_to :merchant
  has_many :invoice_items
end
