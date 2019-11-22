class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant

  has_many :invoice_items
  has_many :transactions
  has_many :items, through: :invoice_items

  validates_presence_of :status

  def self.largest_invoices(limit=5) # With successful transactions
    joins(:invoice_items, :transactions)
    .select("invoices.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
    .merge(Transaction.successful)
    .group(:id)
    .order('total_revenue DESC')
    .limit(limit)
  end

  def self.total_revenue(date)
    joins(:invoice_items, :transactions)
    .where(transactions:{result: :success})
    .where(created_at: date.to_date.all_day) # Tells it to accept all times encompassed within the passed in date
  end
end

# Invoices::RevenueController
# def show
#  Invoice.total_revenue(params[:date])
# end
