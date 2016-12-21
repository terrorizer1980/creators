class AddYtviewsToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :ytviews, :integer
    add_column :channels, :ytvaverage, :integer
  end
end
