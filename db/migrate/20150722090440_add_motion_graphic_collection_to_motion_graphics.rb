class AddMotionGraphicCollectionToMotionGraphics < ActiveRecord::Migration
  def change
    add_reference :motion_graphics, :motion_graphic_collection, index: true, foreign_key: true
  end
end
