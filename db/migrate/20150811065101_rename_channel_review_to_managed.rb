class RenameChannelReviewToManaged < ActiveRecord::Migration
  def change
  	rename_column :channels, :review, :managed
  end
end
