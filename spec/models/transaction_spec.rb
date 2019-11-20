require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'Relationships' do
    it {should belong_to :invoice}
  end

  describe 'Validations' do
    it {should validate_presence_of :credit_card_number}
    it {should validate_presence_of :result}
  end
end
