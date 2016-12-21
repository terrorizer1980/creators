class FetchYoutubeVideoStatsJob < ActiveJob::Base

  queue_as :default
  
  include YoutubeHelper

	def perform(channel_id)
		channel 	= Channel.find_by_id(channel_id)
		raw 	= channel.url 
		joblog "FetchYoutubeVideoStats:\t"
		joblog channel.slug
		joblog raw

		apiurl 		= "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId="
	  	apiurl		+= raw
		apiurl		+= "&type=video"
		apiurl		+= "&maxResults=50"
		apiurl		+= "&key=AIzaSyAjxvcJAeh8t2dQm5hGJ8yYN97Bjgv6QPg&pageToken="
		next_page	= ""
		
		begin
			fetchurl = apiurl + next_page
			resp = JSON.load(open(fetchurl))
			puts "URL: " + fetchurl
			puts " "
			
			resp['items'].each do |r|
				
				ytvid 			= r['id']['videoId']
				etag 			= r['etag']
				published_at 	= r['snippet']['publishedAt']
				name	 		= r['snippet']['title']
				description	  	=	r['snippet']['description']
				thumbdefault 	= r['snippet']['thumbnails']['default']['url']
				thumbmed		= r['snippet']['thumbnails']['medium']['url']
				thumbhigh		= r['snippet']['thumbnails']['high']['url']
              
#                largest = get_largest_thumbnail r['snippet']['thumbnails'].values
#                puts 'largest: ' + r['snippet']['thumbnails'].values.to_s
              
                largest = youtube_get_video_thumbnail ytvid

				existingVid = Video.find_by channel_id: channel.id, ytvid: ytvid
				if existingVid.present?
					existingVid.update(
						etag: etag,
						published_at: published_at,
						name: name,
						description: description,
						thumbdefault: thumbdefault,
						thumbmed: thumbmed,
						thumbhigh: thumbhigh,
                        remote_thumbnail_local_url: largest,
						progress: :imported
					)
				else
					Video.create(
						channel_id: channel.id,
						name: name,
						progress: :imported,
						#uuid: SecureRandom.uuid,
						ytvid: ytvid,
						etag: etag,
						published_at: published_at,
						description: description,
						thumbdefault: thumbdefault,
						thumbmed: thumbmed,
						thumbhigh: thumbhigh,
                        remote_thumbnail_local_url: largest,
                        progress: :imported
					)
				end
			end
	    next_page = resp['nextPageToken']
    end while next_page
  end
end