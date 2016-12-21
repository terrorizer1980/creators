class ArticleCollection < ActiveRecord::Base
  has_and_belongs_to_many :articles
  
  default_scope { order('article_collections.id DESC') }
  
#  named_scope :published, :conditions => { :published => true }
#  scope :confirmed, :conditions => { :confirmed => true }
  
  enum category: 
    { uncategorized: 0,
      seo_and_marketing: 1,
      video_monetization: 2,
      video_production: 3,
      youtube_policies: 4,
      motion_graphics: 5
    }
end
