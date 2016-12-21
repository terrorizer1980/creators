class CreateArticleCollectionsArticles < ActiveRecord::Migration
  def change
    create_table :article_collections_articles do |t|
      t.references :article_collection, index: true, foreign_key: true
      t.references :article, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
