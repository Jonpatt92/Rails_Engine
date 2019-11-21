require './app/models/modules/decimalable'

class InvoiceItem < ApplicationRecord
  include Decimalable

  belongs_to :item
  belongs_to :invoice

  after_validation :convert_to_decimal

  validates_presence_of :unit_price,
                          :quantity
end
