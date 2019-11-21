require './app/models/modules/decimalable'

class InvoiceItem < ApplicationRecord
  include Decimalable

  belongs_to :item
  belongs_to :invoice

  before_validation :convert_to_decimal
end
