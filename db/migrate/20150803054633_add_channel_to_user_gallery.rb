class AddChannelToUserGallery < ActiveRecord::Migration
  def change
    add_reference :user_galleries, :channel, index: true, foreign_key: true
  end
end
