class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices


  validates_presence_of :name

  # With date arg will show total revenue across all successful transactions #
  # for the specified date. Otherwise returns total_revenue for all dates #
  # Date must be string format, 'YYYY-MM-DD' #
  # ex: Merchant.total_revenue("2012-03-25") #
  def self.total_revenue(date)
    # if date != nil
      select("SUM(invoice_items.quantity*invoice_items.unit_price) AS total_revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.successful)
      .where(invoices: {created_at: date.to_date.all_day}) # Accepts all times for specified date
      .take
    # else
    #   joins(invoices: [:invoice_items, :transactions])
    #   .merge(Transaction.successful)
    #   .sum('unit_price * quantity')
    #   .take
    # end
  end
end
