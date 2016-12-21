class AddApprovedToNews < ActiveRecord::Migration
  def change
    add_column :news, :approved, :boolean
  end
end
