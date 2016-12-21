class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.references :channel, index: true, foreign_key: true
      t.string :name
      t.integer :progress
      t.string :uuid
      t.timestamps null: false
    end
  end
end
