FactoryBot.define do
  factory :invoice do
    status { "shipped" }
    customer
    merchant

    after(:create) do |invoice|
      create_list(:transaction,
                             2,
               invoice: invoice
      )
    end

    after(:create) do |invoice|
      create_list(:invoice_item,
                              2,
               invoice: invoice,
 item: invoice.merchant.items[0]
      )
    end
  end
end
