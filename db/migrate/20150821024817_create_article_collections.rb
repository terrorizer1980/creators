class CreateArticleCollections < ActiveRecord::Migration
  def change
    create_table :article_collections do |t|
      t.string :name
      t.string :description
      t.string :picture
      t.string :slug
      t.integer :category

      t.timestamps null: false
    end
  end
end
