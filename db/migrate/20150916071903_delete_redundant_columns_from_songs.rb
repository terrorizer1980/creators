class DeleteRedundantColumnsFromSongs < ActiveRecord::Migration
  def change
    remove_column :songs, :name, :string
    remove_column :songs, :description, :text
  end
end
