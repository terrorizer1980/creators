class RemoveCategoryFromProfile < ActiveRecord::Migration
  def change
  	remove_column :profiles, :category
  end
end
