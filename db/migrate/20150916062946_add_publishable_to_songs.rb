class AddPublishableToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :title, :string
    add_column :songs, :content, :text
    add_column :songs, :content_html, :text
    add_column :songs, :summary_html, :text
    add_column :songs, :approved, :boolean
    add_column :songs, :publish_at, :datetime
    add_column :songs, :thumburl, :string
  end  
end
