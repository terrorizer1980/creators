class CreateChannelCategories < ActiveRecord::Migration
  def change
    create_table :channel_categories do |t|
      t.references :channel, index: true, foreign_key: true
      t.string :description

      t.timestamps null: false
    end
  end
end
