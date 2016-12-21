class CreateMotionGraphicCollections < ActiveRecord::Migration
  def change
    create_table :motion_graphic_collections do |t|
      t.string :name
      t.string :description

      t.timestamps null: false
    end
  end
end
