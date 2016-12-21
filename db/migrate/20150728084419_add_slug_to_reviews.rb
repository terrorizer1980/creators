class AddSlugToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :slug, :string, index: true
    add_column :reviews, :sexyname, :string
  end
end
