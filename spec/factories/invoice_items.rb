FactoryBot.define do
  factory :invoice_item do
    quantity { 1 }
    unit_price { 5.00 }
    item
    invoice
  end
end
