module YoutubeHelper

  require 'open-uri'
  
  class YoutubeError < StandardError
  end
  
  def sanitize_youtube_url_new(rawurl)
    if rawurl.include?("/")
      rawurl = rawurl.split("/").last
    end

    if rawurl.include?("?")
      rawurl = rawurl.split("?").first
    end
    
    rawurl
  end
  
  def sanitize_youtube_url_old(rawurl)
    if rawurl.include?("/")
      rawurl = rawurl.split("/").last
    end

    if rawurl.include?("?")
      rawurl = rawurl.split("?").first
    end
    
    rawurl
  end
  
  def sanitize_youtube_url(full_url)
      if full_url.include?("/user")
        sanitize_youtube_url_old(full_old)
      else
        sanitize_youtube_url_new(full_url)
      end
  end
  
  def load_youtube_params(channel, rawurl)
		apiurl = "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId="
		apiurl += rawurl
		apiurl += "&type=channel&key=AIzaSyAjxvcJAeh8t2dQm5hGJ8yYN97Bjgv6QPg"
		
		begin
			resp = JSON.load(open(apiurl))
		rescue
			raise YoutubeError, 'Could not load information from YouTube. Try again later.'
		else
			unless resp['error'].nil?
				raise YoutubeError, 'Error loading channel info from YouTube: ' + resp['error']['errors'][0]['message']
			end
			
			items = resp['pageInfo']['totalResults']

			index = 0
			items.times do |i|
			  break if resp['items'][i]['id']['kind'] == "youtube#channel"
			  index = index + 1
			end
			
			if index == 0
#				raise YouTubeError, 'No channel info returned from YouTube. This is probably an invalid channel id'
			end

			channel.url = rawurl
			unless resp['items'][index] == nil
				channel.name         = resp['items'][index]['snippet']['title'].to_s
				channel.publishedat  = resp['items'][index]['snippet']['publishedAt'].to_s
				channel.notes        = resp['items'][index]['snippet']['description'].to_s
				channel.thumbdefault = resp['items'][index]['snippet']['thumbnails']['default']['url'].to_s
				channel.thumbmed     = resp['items'][index]['snippet']['thumbnails']['medium']['url'].to_s
				channel.thumbhigh    = resp['items'][index]['snippet']['thumbnails']['high']['url'].to_s
			else
				raise YoutubeError, 'No channel info returned from YouTube. This is probably an invalid channel id'
			end
			channel.apidata = resp.to_s
		end
	end
  
  def get_largest_thumbnail(thumbnail_list)
    largest_thumbnail = nil
    current_largest = 0
    
    thumbnail_list.each do | thumbnail |
      unless thumbnail.nil?
        current_size = thumbnail['width'].to_i * thumbnail['height'].to_i
        if current_size > current_largest
          largest_thumbnail = thumbnail
          current_largest = current_size
        end
      end
    end
    
    largest_thumbnail
  end
  
  def youtube_get_video_thumbnail(video_id)
    
    fetchurl  = 'https://www.googleapis.com/youtube/v3/videos?key=AIzaSyAjxvcJAeh8t2dQm5hGJ8yYN97Bjgv6QPg&part=snippet&id=' + video_id
    
    begin
      resp = JSON.load(open(fetchurl))
    rescue
      raise YoutubeError, 'Could not load information from YouTube. Try again later.'
    else
      
      unless resp['error'].nil?
        raise YoutubeError, 'Error loading channel info from YouTube: ' + resp['error']['errors'][0]['message']
      end
      
      unless resp['items'][0] == nil
        
        puts resp['items'][0]['snippet']['thumbnails'].values
        largest = get_largest_thumbnail resp['items'][0]['snippet']['thumbnails'].values
        puts 'YouTube Thumnail URL: ' + largest['url'].to_s    
        
        unless largest.nil?
          largest['url'].to_s
        else
          nil
        end
      else
        raise YoutubeError, 'No channel info returned from YouTube. This is probably an invalid channel id'
      end
      
    end
  end
end