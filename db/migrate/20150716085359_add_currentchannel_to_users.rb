class AddCurrentchannelToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_channel_id, :integer
  end
end
