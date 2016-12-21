class DeleteRedundantColumnsFromMotionGraphics < ActiveRecord::Migration
  def change
    remove_column :motion_graphics, :name, :string
    remove_column :motion_graphics, :description, :text
  end
end
