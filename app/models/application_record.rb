class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.random
    find(self.pluck(:id).sample)
  end
end
