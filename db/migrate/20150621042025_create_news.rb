class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.references :user, index: true
      t.string :title
      t.text :content
      t.integer :category, default: 0, null: false
      t.string :vidurl

      t.timestamps null: false
    end
    add_foreign_key :news, :users
  end
end
