class UserGallery < ActiveRecord::Base
	belongs_to :user
	belongs_to :channel
	has_many :gallery_images, dependent: :destroy
  
  def self.motion_graphic_customization_gallery(user, channel)
#    self.get_gallery(user, channel, :motion_graphic_customization)
    UserGallery.where(
      :user => user, 
      :channel => channel, 
      :gallery_type => UserGallery.gallery_types['motion_graphic_customization'])
    .first_or_create
  end

  def self.thumbnail_background_gallery(user, channel)
#    self.get_gallery(user, channel, :thumbnail_background)
    UserGallery.where(
      :user => user, 
      :channel => channel, 
      :gallery_type => UserGallery.gallery_types['thumbnail_background'])
    .first_or_create
  end
  
  def self.thumbnail_overlay_gallery(user, channel)
#    self.get_gallery(user, channel, :thumbnail_overlay)
    UserGallery.where(
      :user => user, 
      :channel => channel, 
      :gallery_type => UserGallery.gallery_types['thumbnail_overlay'])
    .first_or_create
  end
  
  def self.get_gallery(user, channel, gallery_type)
    UserGallery.where(
      :user => user, 
      :channel => channel, 
      :gallery_type => UserGallery.gallery_types[gallery_type])
    .first_or_create
  end
  
  enum gallery_type: 
		{ thumbnail_overlay: 0, thumbnail_background: 1, motion_graphic_customization: 2 }
end