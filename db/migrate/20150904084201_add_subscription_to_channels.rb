class AddSubscriptionToChannels < ActiveRecord::Migration
  def change
    add_reference :channels, :subscription, index: true, foreign_key: true
  end
end
