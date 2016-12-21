class AddProductToMotionGraphics < ActiveRecord::Migration
  def change
    add_reference :motion_graphics, :product, index: true, foreign_key: true
  end
end
