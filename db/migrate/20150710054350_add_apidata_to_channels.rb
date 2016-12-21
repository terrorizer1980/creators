class AddApidataToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :apidata, :text
  end
end
