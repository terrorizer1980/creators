class AddOnboardedToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :onboarded, :boolean
  end
end
