module Decimalable
  def convert_to_decimal
    self.unit_price = (self.unit_price.to_f / 100)
  end
end
