class Order < ApplicationRecord
  self.primary_key = 'order_id'
  belongs_to :customer, foreign_key: 'external_customer_id'
end
