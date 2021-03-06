class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices

  validates_presence_of :name

  ## With date arg will show total revenue across all successful transactions ##
  ## for the specified date. Otherwise returns total_revenue for all dates ##
  ## Date must be string format, 'YYYY-MM-DD' ##
  ## ex: Merchant.total_revenue("2012-03-25") ##
  ## /revenue?date=x returns the total revenue for date x across all merchants ##
  def self.total_revenue(date = nil)
    if date != nil
      select("SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.successful)
      .where(invoices: {created_at: date.to_date.all_day}) # Accepts all times for specified date
      .take
    else
      select("SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.successful)
      .take
    end
  end

  ## /most_revenue?quantity=x Returns the top x merchants ranked by total revenue ##
  def self.most_revenue(quantity)
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .group('merchants.id')
    .order('revenue desc')
    .limit(quantity)
  end

  ## /:id/favorite_customer returns the customer who has conducted the most total number of successful transactions ##
  def favorite_customer
    customers
    .select("customers.*, COUNT(distinct transactions.id) AS successful_transactions")
    .joins(:transactions)
    .merge(Transaction.successful)
    .where(invoices: {merchant_id: id})
    .group('customers.id')
    .order('successful_transactions desc')
    .first
  end
end
