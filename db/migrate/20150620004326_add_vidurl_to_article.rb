class AddVidurlToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :vidurl, :string
  end
end
