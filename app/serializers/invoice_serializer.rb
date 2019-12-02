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
  has_many :invoice_items
  has_many :transactions

  attribute :payment_status do |object|
    unless Transaction.where("invoice_id = ?", object.id) == []
      if object.transactions[0][:result] == "success"
        "paid"
      elsif object.transactions[0][:result] == "failed"
        "unpaid"
      end
    end
  end
end
