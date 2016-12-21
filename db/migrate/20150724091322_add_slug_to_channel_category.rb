class AddSlugToChannelCategory < ActiveRecord::Migration
  def change
    add_column :channel_categories, :slug, :string
    add_index :channel_categories, :slug
  end
end


