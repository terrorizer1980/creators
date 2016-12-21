class CreatePresets < ActiveRecord::Migration
  def change
    create_table :presets do |t|
      t.references :channel, index: true, foreign_key: true
      t.string :name
      t.integer :intro_template_id
      t.boolean :customizeintropervideo, default: false
      t.integer :background_template_id
      t.integer :l3_template_id
      t.integer :endcard_template_id
      t.string  :slug, index: true, unique: true

      t.timestamps null: false
    end
  end
end
