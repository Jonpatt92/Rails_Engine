FactoryBot.define do
  factory :item do
    name { "Docile Gorilla" }
    description { "One well behaved gorilla" }
    unit_price { 10.00 }
    merchant
  end
end
