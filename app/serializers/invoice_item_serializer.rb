class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :quantity, :unit_price, :item_id, :invoice_id

  attribute :created_at do |object|
    Date.parse(object.created_at.to_s)
  end

  attribute :updated_at do |object|
    Date.parse(object.updated_at.to_s)
  end

  belongs_to :item
  belongs_to :invoice
end
