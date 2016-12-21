class AddNotesToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :notes, :text
    add_column :channels, :review, :boolean, default: true
    add_column :channels, :platform, :integer, default: 0
  end
end
