class AddStaffonlyToNews < ActiveRecord::Migration
  def change
    add_column :news, :staffonly, :boolean, default: false
  end
end
