class AddSongDataToProduct < ActiveRecord::Migration
  def change
    Product.connection.execute('INSERT into products (type, name, price, description, custom, status, created_at, updated_at) VALUES (\'SongProduct\', \'Royalty Free Music Track\', 150, \'A single arranged audio track based on one of our audio track samples\', \'audio track\', 0, \'2015-08-01 00:00:00\', \'2015-08-01 00:00:00\')')
  end
end
