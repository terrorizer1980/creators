class GiftVoucher < ActiveRecord::Base
  belongs_to :from_user, :class_name => 'User'
  belongs_to :user
  has_one :order
  
  has_many :gift_voucher_items
  
  def from_user_text
    from_text + (anonymous ? '' : ' (' + from_user.nickname + ')')
  end
  
  def to_user_text
    to_text
  end
  
  enum status:
  {
    unclaimed: 0,
    claimed: 1,
    partial: 2
  }
  
  scope :not_claimed, -> { where.not(:status => GiftVoucher.statuses['claimed']) }
  scope :claimed, -> { where(:status => GiftVoucher.statuses['claimed']) }
end
