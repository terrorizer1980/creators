module Publishable
  extend ActiveSupport::Concern
  
  include ApplicationHelper
  
  ## Publishable assumes the following fields:
  ##    user_id (author / contributor)
  ##    title
  ##    content (description)
  ##    content_html (automatically generated html from markdown)
  ##    summary_html (html to 30 words)
  ##    approved (allowed to be visible)
  ##    publish_at (date when item will become visible)
  ##    vidurl (YouTube url)
  ##    thumburl (Image url)
  
  included do
    belongs_to :user
    
#    default_scope { order('publish_at DESC') }
    scope :published, -> { where('approved = ? AND publish_at < ?', true, DateTime.now) }
    
    mount_uploader :thumburl, VideoThumbnailUploader
    
    validates :user, presence: true
    
    def get_content_safe
      content_html.nil? ? markdown(content) : content_html.html_safe
    end
    
    def get_summary_safe
      summary_html.nil? ? HTML_Truncator.truncate(markdown(content), 30).html_safe : summary_html.html_safe
    end
    
    def feed_icon
      'newspaper'
    end
    
    self.per_page = 8
  end
  
  module ClassMethods
      
  end
end