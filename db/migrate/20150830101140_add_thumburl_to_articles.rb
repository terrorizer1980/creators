class AddThumburlToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :thumburl, :string
  end
end
