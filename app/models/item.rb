require './app/models/modules/decimalable'

class Item < ApplicationRecord
  include Decimalable

  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  after_validation :convert_to_decimal

  validates_presence_of :name,
                 :description,
                   :unit_price

  def self.most_revenue(quantity)
    select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(invoice_items: [invoice: :transactions])
    .merge(Transaction.successful)
    .group('items.id')
    .order('revenue desc')
    .limit(quantity)
  end
end
