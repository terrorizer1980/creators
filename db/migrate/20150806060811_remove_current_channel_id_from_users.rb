class RemoveCurrentChannelIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :current_channel_id, :integer
  end
end
