class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :user
  belongs_to :channel
  belongs_to :product
  belongs_to :purchasable, polymorphic: true
end