class AddCustomFieldsToMotionGraphics < ActiveRecord::Migration
  def change
    add_column :motion_graphics, :custom_fields, :text
  end
end
