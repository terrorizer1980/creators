class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.references :user, index: true, foreign_key: true
      t.string :url
      t.string :name
      t.string :slug, index: true, unique: true
      t.timestamps null: false
    end
  end
end
