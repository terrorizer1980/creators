class AddAdvisorsToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :artist, :integer
    add_column :profiles, :advisor, :integer
  end
end
