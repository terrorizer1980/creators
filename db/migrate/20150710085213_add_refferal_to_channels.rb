class AddRefferalToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :referral, :boolean, default: false
    add_column :channels, :reffedby, :int
  end
end
