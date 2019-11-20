FactoryBot.define do
  factory :invoice_item do
    quantity { "MyString" }
    unit_price { 1.5 }
    item { nil }
    invoice { nil }
  end
end
