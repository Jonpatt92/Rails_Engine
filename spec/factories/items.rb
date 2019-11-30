FactoryBot.define do
  factory :item do
    name { "An Item" }
    description { "This is an item" }
    unit_price { 10.00 }
    merchant
  end
end
