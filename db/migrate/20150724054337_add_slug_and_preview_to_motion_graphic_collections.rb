class AddSlugAndPreviewToMotionGraphicCollections < ActiveRecord::Migration
  def change
    add_column :motion_graphic_collections, :slug, :string
    add_column :motion_graphic_collections, :preview, :string
  end
end
