class AddPresetToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :preset_id, :integer
  end
end
