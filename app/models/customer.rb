class Customer < ApplicationRecord
  self.primary_key = 'customer_id'
  has_many :orders, foreign_key: 'external_customer_id'
end
