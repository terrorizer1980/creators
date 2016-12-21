class AddAvatarToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :avatar, :string
    add_column :profiles, :bio, :string
  end
end
