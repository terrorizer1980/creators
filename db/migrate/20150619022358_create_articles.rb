class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.boolean :approved
      t.integer :category, default: 0, null: false
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :articles, :users
  end
end
