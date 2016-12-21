class Article < ActiveRecord::Base
  extend FriendlyId
    friendly_id :title, use: :slugged
  
  include Publishable
  
  default_scope { order('publish_at DESC') }
	
  has_and_belongs_to_many :article_collections

  enum category: 
    { uncategorized: 0,
      seo_and_marketing: 1,
      video_monetization: 2,
      video_production: 3,
      youtube_policies: 4,
      motion_graphics: 5
    }
  
  ## TODO: This is pretty bad practice, view concerns in the model
  def feed_icon
    vidurl? ? 'youtube play' : 'browser'
  end
  
end
