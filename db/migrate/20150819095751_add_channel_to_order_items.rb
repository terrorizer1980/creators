class AddChannelToOrderItems < ActiveRecord::Migration
  def change
    add_reference :order_items, :channel, index: true, foreign_key: true
  end
end
