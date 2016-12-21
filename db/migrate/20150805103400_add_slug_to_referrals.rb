class AddSlugToReferrals < ActiveRecord::Migration
  def change
    add_column :referrals, :slug, :string
  end
end
