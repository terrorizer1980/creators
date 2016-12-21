class Channel < ActiveRecord::Base
  
  ## TODO: add (polymorphic?) association to allow channel to be associated with order_item
	extend FriendlyId
  friendly_id :name, use: :slugged
	
  mount_uploader :thumbuploaded, PreviewUploader

  belongs_to :channel_category
  belongs_to :plan
  belongs_to :subscription
  belongs_to :user

  has_many :order_items
  has_many :videos, dependent: :destroy
  has_many :presets, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :thumbnail_presets, dependent: :destroy

  has_one :apps_collaboration_pref, dependent: :destroy

  before_destroy :clear_selected_channel

  enum platform: 
	{ youtube: 0,
		other: 1
	}

  validates_uniqueness_of :url, :scope => [:user_id], :allow_blank => true
  validates_length_of :name, :minimum => 5, :allow_nil => false
  
#  self.per_page = 15
  private

  def clear_selected_channel
    prof = self.user.profile
    prof.update(selected_channel: nil) if prof.selected_channel == self.id
  end


end
