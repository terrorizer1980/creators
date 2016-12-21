class CreateGalleryImages < ActiveRecord::Migration
  def change
    create_table :gallery_images do |t|
			t.references :user_gallery, index: true, foreign_key: true
			t.string :name
			t.string :url
			t.timestamps null: false
    end
  end
end
