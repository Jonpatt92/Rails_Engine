class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant

  has_many :invoice_items
  has_many :transactions
  has_many :items, through: :invoice_items

  validates_presence_of :status

  def payment_status
    unless Transaction.where("invoice_id = ?", id) == []
      if self.transactions[0][:result] == "success"
        "paid"
      elsif self.transactions[0][:result] == "failed"
        "unpaid"
      end
    end
  end

end

  ## Build Endpoint ##
# def self.largest_invoices(limit=5) # With successful transactions
#   joins(:invoice_items, :transactions)
#   .select("invoices.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
#   .merge(Transaction.successful)
#   .group(:id)
#   .order('total_revenue DESC')
#   .limit(limit)
# end
