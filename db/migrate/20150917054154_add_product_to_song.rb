class AddProductToSong < ActiveRecord::Migration
  def change
    add_reference :songs, :product, index: true, foreign_key: true
  end
end
