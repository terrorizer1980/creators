class ArticleCollectionsArticle < ActiveRecord::Base
  belongs_to :article_collection
  belongs_to :article
end
