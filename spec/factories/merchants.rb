FactoryBot.define do
  factory :merchant do
    name { "Banana Stand" }

    after(:create) do |merchant|
      create_list(:item,
                      5,
      merchant: merchant
      )
    end

    after(:create) do |merchant|
      create_list(:invoice,
                         3,
         merchant: merchant
      )
    end
  end
end
