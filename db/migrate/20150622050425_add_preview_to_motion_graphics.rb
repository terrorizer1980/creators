class AddPreviewToMotionGraphics < ActiveRecord::Migration
  def change
    add_column :motion_graphics, :preview, :string
  end
end
