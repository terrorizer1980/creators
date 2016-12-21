class UpdateProductIdForSongs < ActiveRecord::Migration
  def change
    Song.connection.execute('UPDATE songs SET product_id = (SELECT(id) FROM products WHERE name=\'Royalty Free Music Track\')')
  end
end
