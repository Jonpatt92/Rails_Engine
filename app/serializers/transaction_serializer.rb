class TransactionSerializer
  include FastJsonapi::ObjectSerializer

  attribute :id

  attribute :credit_card_number do |obj|
    obj.credit_card_number.to_s
  end

  attributes :result, :created_at, :updated_at, :invoice_id
  belongs_to :invoice
end
