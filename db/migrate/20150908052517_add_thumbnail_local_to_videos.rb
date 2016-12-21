class AddThumbnailLocalToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :thumbnail_local, :string
  end
end
