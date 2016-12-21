class AddOldUrlToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :old_url, :string
  end
end
