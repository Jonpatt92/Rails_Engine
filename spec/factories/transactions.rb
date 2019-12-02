FactoryBot.define do
  factory :transaction do
    credit_card_number { 1234 }
    credit_card_expiration_date { 123 }
    result { "success" }
    invoice
  end
end
