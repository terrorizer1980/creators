class News < ActiveRecord::Base
  extend FriendlyId
    friendly_id :title, use: :slugged
  
  include Publishable
  
  default_scope { order('publish_at DESC') }
  
  enum category: 
  	{ 
      network101_news: 0,
      youtube_news: 1,
      creator_news: 2,
      other: 3
  	}
end