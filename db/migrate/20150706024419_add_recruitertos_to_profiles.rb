class AddRecruitertosToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :recruitertos, :boolean, default: false
  end
end
