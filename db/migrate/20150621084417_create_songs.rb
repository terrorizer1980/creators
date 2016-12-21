class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.integer :category, default: 0, null: false
      t.string :vidurl
      t.text :description
      t.references :user, index: true
      t.string :slug

      t.timestamps null: false
    end
    add_index :songs, :slug, unique: true
    add_foreign_key :songs, :users
  end
end
