class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  belongs_to :gift_voucher
  has_many :order_items, dependent: :destroy
  
  def locked
    false
  end
  
  enum status:
  {
    ordered: 0,
    processing: 1,
    complete: 2,
    delivered: 3,
    received: 4
  }
  
  def to_subclass
    self.becomes(self.type.constantize)
  end
end
