class Profile < ActiveRecord::Base

	extend FriendlyId
  	friendly_id :nickname, use: :slugged

	mount_uploader :avatar, AvatarUploader

	belongs_to :user
	belongs_to :selected_channel, :class_name => "Channel", :foreign_key => :selected_channel_id


end
