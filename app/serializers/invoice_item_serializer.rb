class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer

  attributes :unit_price, :quantity, :item_id, :invoice_id
  belongs_to :item
  belongs_to :invoice
end
