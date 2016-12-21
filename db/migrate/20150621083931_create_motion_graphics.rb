class CreateMotionGraphics < ActiveRecord::Migration
  def change
    create_table :motion_graphics do |t|
      t.string :name
      t.integer :category, default: 0, null: false
      t.string :vidurl
      t.text :description
      t.references :user, index: true
      t.string :slug
      t.timestamps null: false
    end
    add_index :motion_graphics, :slug, unique: true
    add_foreign_key :motion_graphics, :users
  end
end
