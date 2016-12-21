class MotionGraphicCollection < ActiveRecord::Base
	acts_as_taggable
	
	has_many :motion_graphics
	
	extend FriendlyId
  	friendly_id :name, use: :slugged
	
	mount_uploader :preview, PreviewUploader
end
