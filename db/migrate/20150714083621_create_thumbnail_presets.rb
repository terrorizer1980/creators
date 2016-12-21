class CreateThumbnailPresets < ActiveRecord::Migration
  def change
    create_table :thumbnail_presets do |t|
      t.references :channel, index: true, foreign_key: true
      t.string :name
      t.text :content

      t.timestamps null: false
    end
  end
end
