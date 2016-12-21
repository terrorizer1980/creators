class UpdateDataInSongs < ActiveRecord::Migration
  def change
    Song.connection.execute('UPDATE songs SET publish_at = created_at, approved = 1, title = name, content = description')
  end
end
