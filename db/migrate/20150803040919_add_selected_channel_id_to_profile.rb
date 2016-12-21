class AddSelectedChannelIdToProfile < ActiveRecord::Migration
  def change
	  add_reference :profiles, :selected_channel, references: :channels, index: true
	  add_foreign_key :profiles, :channels, column: :selected_channel_id
  end
end
