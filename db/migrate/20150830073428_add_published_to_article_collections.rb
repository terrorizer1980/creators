class AddPublishedToArticleCollections < ActiveRecord::Migration
  def change
    add_column :article_collections, :published, :boolean
    add_column :article_collections, :publish_at, :datetime
  end
end
