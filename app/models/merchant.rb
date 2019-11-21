class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices
  

  validates_presence_of :name
end
