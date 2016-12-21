class AddMoodAndGenreToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :mood, :integer
    add_column :songs, :genre, :integer
  end
end
