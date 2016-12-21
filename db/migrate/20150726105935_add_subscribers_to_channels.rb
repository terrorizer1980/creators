class AddSubscribersToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :subscribers, :integer
  end
end
