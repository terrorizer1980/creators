class GalleryImage < ActiveRecord::Base
	belongs_to :user_gallery
	has_one :user, :through => :user_gallery
	has_one :channel, :through => :user_gallery

	mount_uploader :url, GalleryUploader
	
	attr_accessor :gallery_type
end
