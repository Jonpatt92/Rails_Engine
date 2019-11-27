FactoryBot.define do
  factory :transaction do
    credit_card_number { 123456789 }
    credit_card_expiration_date { 610 }
    result { "success" }
    invoice
  end
end
