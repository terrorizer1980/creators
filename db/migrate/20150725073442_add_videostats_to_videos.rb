class AddVideostatsToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :ytvid, :string
    add_column :videos, :etag, :string
    add_column :videos, :published_at, :datetime
    add_column :videos, :description, :text
    add_column :videos, :thumbdefault, :string
    add_column :videos, :thumbmed, :string
    add_column :videos, :thumbhigh, :string
  end
end
