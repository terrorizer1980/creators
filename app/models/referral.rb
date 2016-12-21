class Referral < ActiveRecord::Base
  belongs_to :user
  
  extend FriendlyId
    friendly_id :name, use: :slugged

  enum status: 
  { 
    prospective: 0,
    contacted: 1,
    pitched: 2,
    trialling: 3,
    subscribed: 4,
    cancelled: 5,
    claimed: 6,
    paid: 7
  }

  enum channel_type:
  { 
    youtube: 0,
    other: 1
  }
  
#  scope :starts_with, -> (name) { where("name like ?", "#{name}%")}
  
  scope :status, -> (status) { where status: status }
  scope :prospective, -> { status(Referral.statuses['prospective']) }
  scope :contacted, -> { status(Referral.statuses['contacted']) }
  scope :pitched, -> { status(Referral.statuses['pitched']) }
  # initiated summarizes prospective, contacted and pitched
  scope :initiated, -> { status([Referral.statuses['prospective'], Referral.statuses['contacted'], Referral.statuses['pitched']]) }
  scope :trialling, -> { status(Referral.statuses['trialling']) }
  scope :subscribed, -> { status(Referral.statuses['subscribed']) }
  scope :cancelled, -> { status(Referral.statuses['cancelled']) }
  scope :claimed, -> { status(Referral.statuses['claimed']) }
  scope :paid, -> { status(Referral.statuses['paid']) }
  # rewarded summarizes subscribed, claimed and paid
  scope :successful, -> { status([Referral.statuses['subscribed'], Referral.statuses['claimed'], Referral.statuses['paid']]) }
  
  def self.matched_users(current_user)
    # TODO: this won't work unless the emails are formatted exactly the same. Should convert to lowercase and remove spacing.
    User.where('email IN (' + current_user.referrals.select('email').to_sql + ')', current_user.email)
  end
  
  def self.matched_channels(current_user)
    # TODO: this won't work unless the channel_urls are formatted exactly the same. 
    # At present, there is not conversion occurring in the referral because it can
    # be entered as a user-style URL. Should do something to make sure it matches
    Channel.where('url IN (' + current_user.referrals.select('channel_id').to_sql + ') OR old_url IN (' + current_user.referrals.select('channel_id').to_sql + ')')
    
  end
  
  validates_inclusion_of :status, in: statuses
  validates_inclusion_of :channel_type, in: channel_types
  
  #self.per_page = 2
end
