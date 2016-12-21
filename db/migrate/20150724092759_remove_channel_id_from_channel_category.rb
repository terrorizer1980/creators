class RemoveChannelIdFromChannelCategory < ActiveRecord::Migration
  def change
    remove_foreign_key :channel_categories, :channel
    remove_column :channel_categories, :channel_id, :integer
    add_column :channels, :channel_category_id, :integer, null: false, default: 1
  end
end
