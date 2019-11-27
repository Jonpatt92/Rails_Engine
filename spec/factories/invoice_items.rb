FactoryBot.define do
  factory :invoice_item do
    quantity { 3 }
    unit_price { 500 }
    item
    invoice
    
  end
end
