class AddApistuffToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :publishedat, :datetime
    add_column :channels, :thumbdefault, :string
    add_column :channels, :thumbmed, :string
    add_column :channels, :thumbhigh, :string
  end
end
