class InvoiceSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :status, :merchant_id, :customer_id

  attribute :created_at do |object|
    Date.parse(object.created_at.to_s)
  end

  attribute :updated_at do |object|
    Date.parse(object.updated_at.to_s)
  end

  belongs_to :merchant
  belongs_to :customer


  attribute :payment_status do |invoice|
    invoice.payment_status
  end
end
