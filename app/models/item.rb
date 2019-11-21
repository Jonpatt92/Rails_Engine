require './app/models/modules/decimalable'

class Item < ApplicationRecord
  include Decimalable
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  before_validation :convert_to_decimal
end
