class Transaction < ApplicationRecord
  belongs_to :invoice

  ## Creates a Lambda object using a '->' 'stabby lambda' ##
  ## Can be called like a class method ##
  ## Filters out any Transactions with a result ##
  ## other than 'success' ##
  scope :successful, -> { where(result: 'success') }

  validates_presence_of :credit_card_number,
                                    :result
end
