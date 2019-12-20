require './app/models/modules/decimalable'

class Item < ApplicationRecord
  include Decimalable

  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  after_validation :convert_to_decimal

  validates_presence_of :name,
                 :description,
                   :unit_price

## /most_revenue?quantity=x Returns the top x items ranked by total revenue ##
  def self.most_revenue(quantity)
    select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(invoice_items: [invoice: :transactions])
    .merge(Transaction.successful)
    .group('items.id')
    .order('revenue desc')
    .limit(quantity)
  end

  ## /api/v1/items/:id/best_day returns the date with the most sales for the given item using the invoice date. ##
  ## If there are multiple days with equal number of sales, return the most recent day. ##
  def self.best_day(filter = {})
    select("invoices.created_at::date, sum(invoice_items.quantity) AS purchases")
    .joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .where(invoice_items: filter)
    .group('invoices.created_at::date')
    .order('purchases desc, invoices.created_at::date desc')
    .first
  end
end
