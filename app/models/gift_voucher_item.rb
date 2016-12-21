class GiftVoucherItem < ActiveRecord::Base
  belongs_to :gift_voucher
  belongs_to :product
  
  enum status: 
  {
    unclaimed: 0,
    claimed: 1
  }
  
  scope :not_claimed, -> { where.not(:status => GiftVoucher.statuses['claimed']) }
  scope :claimed, -> { where(:status => GiftVoucher.statuses['claimed']) }
  
end
