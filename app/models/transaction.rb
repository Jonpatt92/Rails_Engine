class Transaction < ApplicationRecord
  belongs_to :invoice

  scope :successful, -> { where(result: 'success') }
  # Creates a Lambda object using a '->' 'stabby lambda'.
  # Can be called like a class method.
  # Filters out any Transactions with a result other than 'success'

  validates_presence_of :credit_card_number,
                                    :result
end

# def self.successfull
#   where(result: 'success')
# end
