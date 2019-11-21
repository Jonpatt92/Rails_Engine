require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'Relationships' do
    it {should have_many(:items)}
    it {should have_many(:invoices)}
    it {should have_many(:transactions).through(:invoices)}
    it {should have_many(:invoice_items).through(:invoices)}
    it {should have_many(:customers).through(:invoices)}
  end

  describe 'Validations' do
    it {should validate_presence_of(:name)}
  end
end
