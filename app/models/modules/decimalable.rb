module Decimalable
  def convert_to_decimal
    unless self.unit_price.class == Float
      self.unit_price = (self.unit_price.to_f / 100)
    end
  end
end
