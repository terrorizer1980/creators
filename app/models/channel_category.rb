class ChannelCategory < ActiveRecord::Base
	extend FriendlyId
  friendly_id :description, use: :slugged

	has_many :channels

  validates :description, uniqueness: true
end
