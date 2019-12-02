class TransactionSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :credit_card_number, :credit_card_expiration_date, :result, :invoice_id

  attribute :created_at do |object|
    Date.parse(object.created_at.to_s)
  end

  attribute :updated_at do |object|
    Date.parse(object.updated_at.to_s)
  end

  belongs_to :invoice
end
