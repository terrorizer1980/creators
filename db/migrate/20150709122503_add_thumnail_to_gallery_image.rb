class AddThumnailToGalleryImage < ActiveRecord::Migration
  def change
    add_column :gallery_images, :Url_thumb, :string
  end
end
