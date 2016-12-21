class CreateMotionGraphicCustomizations < ActiveRecord::Migration
  def change
    create_table :motion_graphic_customizations do |t|
      t.references :user, index: true, foreign_key: true
		t.integer :motion_graphic_id
      t.text :custom_field_data

      t.timestamps null: false
    end
  end
end
