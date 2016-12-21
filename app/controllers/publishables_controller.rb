class PublishablesController < ApplicationController
  
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
  
  include YoutubeHelper
  
  protected
  
  def set_publishable_params(p, m)
    p[:content_html] = markdown(p[:content])
    p[:summary_html] = HTML_Truncator.truncate(p[:content_html], 30)
    if p[:remote_thumburl_url].blank?
      if p[:vidurl].present?
        begin
          remote_thumburl = youtube_get_video_thumbnail(p[:vidurl])
          p[:remote_thumburl_url] = remote_thumburl
        rescue 
          flash[:alert] = 'Could not load information from YouTube. Try again later.'
        end
      else
        m.remove_thumburl = true
      end
    end
  end
end
