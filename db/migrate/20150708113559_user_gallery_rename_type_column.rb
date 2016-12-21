class UserGalleryRenameTypeColumn < ActiveRecord::Migration
  def change
	rename_column :user_galleries, :type, :gallery_type
  end
end
