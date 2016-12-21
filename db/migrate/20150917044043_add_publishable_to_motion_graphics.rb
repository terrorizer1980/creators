class AddPublishableToMotionGraphics < ActiveRecord::Migration
  def change
    add_column :motion_graphics, :title, :string
    add_column :motion_graphics, :content, :text
    add_column :motion_graphics, :content_html, :text
    add_column :motion_graphics, :summary_html, :text
    add_column :motion_graphics, :approved, :boolean
    add_column :motion_graphics, :publish_at, :datetime
    add_column :motion_graphics, :thumburl, :string
  end
end
