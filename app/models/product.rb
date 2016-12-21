class Product < ActiveRecord::Base
  has_many :motion_graphics
  has_many :order_item
  has_many :gift_voucher_item
  
  enum status: 
  	{ Available: 0, 
      Out_of_Stock: 1, 
      Discontinued: 2
  	}
  
  def can_customize
    true
  end
  
  def has_gallery
    true
  end
end
