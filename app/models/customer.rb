class Customer < ApplicationRecord
  has_many :invoices

  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :merchants, through: :invoices

  validates_presence_of :first_name,
                         :last_name

  ## /:id/favorite_merchant returns a merchant ##
  ## where the customer has conducted the most successful transactions ##
  def favorite_merchant
    merchants
    .select("merchants.*, COUNT(distinct transactions.id) AS successful_transactions")
    .joins(:transactions)
    .merge(Transaction.successful)
    .group('merchants.id')
    .order('successful_transactions desc')
    .first
  end
end
