class Transaction < ApplicationRecord
  belongs_to :invoice

  scope :successful, -> { where(result: 'success') } # Creates a Lambda object using a '->' 'stabby lambda'.
  # Can be called like a class method. Filters out any Transactions with a result other than 'success'
end

# def self.successfull
# where(result: 'success')
# end

# default_scope { where(result: 'success') } # This will run with every query made to the Transaction model. Also applied when making a record.
# DON'T USE DEFAULT SCOPES, they will complicate large databases and cause unexpected behavior.
