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
end
