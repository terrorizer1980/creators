class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, :omniauthable

  has_one  :profile, dependent: :destroy
  has_one  :subscription

  has_many :channels, dependent: :destroy
  has_many :presets, dependent: :destroy
  has_many :referrals, dependent: :destroy
#  has_many :requests, dependent: :destroy
  
  has_many :purchases, dependent: :destroy
  has_many :baskets, dependent: :destroy
  has_many :wishlists, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :gift_vouchers, dependent: :destroy, foreign_key: :to_user_id

  has_many :user_galleries, dependent: :destroy
  has_many :videos, dependent: :destroy

  has_many :reviews #no dependent destroy - user refers to the advisor, not the channel owner
  has_many :txes # keep transactions forever

  #TODO: figure out how to safely delete reviews when channel deleted.
  # hint: before_delete callback.
  
  delegate :nickname, :to => :profile, :allow_nil => true
  delegate :fname, :to => :profile, :allow_nil => true
  delegate :lname, :to => :profile, :allow_nil => true
  delegate :bio, :to => :profile, :allow_nil => true
  delegate :recruitertos, :to => :profile, :allow_nil => true
  delegate :selected_channel, :to => :profile, :allow_nil => true
  delegate :avatar, :to => :profile, :allow_nil => true
  delegate :avatar_url, :to => :profile, :allow_nil => true
  delegate :onboarded, :to => :profile, :allow_nil => true
  delegate :skype, :to => :profile, :allow_nil => true
  delegate :artist, :to => :profile, :allow_nil => false
  delegate :advisor, :to => :profile, :allow_nil => false
  
  def basket
    baskets.first_or_create.becomes(Order)
  end
  
  def last_seen_at
    last_sign_in_at.nil? ? created_at : last_sign_in_at
  end

  enum baserole: 
  { 
      client: 0,
      staff: 1
  }

  enum staffrole: 
  { 
      terminated: 0,
      artist: 1,
      advisor: 2,
      artisttrainee: 3,
      advisortrainee: 4,
      admin: 5
  }

  enum clientstatus: 
  { 
      registering: 0,
      free: 1,
      premium: 2,
      cancelled: 3
  }
  
  self.per_page = 20
  
end
