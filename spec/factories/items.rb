FactoryBot.define do
  factory :item do
    name { "An Item" }
    description { "This is an item" }
    unit_price { 200 }
    merchant
  end
end
