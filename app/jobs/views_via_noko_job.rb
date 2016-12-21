class ViewsViaNokoJob < ActiveJob::Base
  queue_as :default

  def perform(channel)

    chan = Channel.find_by_id(channel) 
		joblog "ViewsViaNoko:\t\t" + chan.slug + "\tstart"
		runningtotal = 0	
		vids = chan.videos.where("published_at < ?", Time.now - 2.days).order(published_at: :desc).limit(5)
    vids.each do |v|

	    raw = v.ytvid	
			joblog "ViewsViaNoko:\t\tVideo: " + v.name
		
			url = "https://www.youtube.com/watch?v=" + raw
			
			doc = Nokogiri::HTML(open(url))

			views = doc.xpath('//*[@id="watch7-views-info"]/div[1]').first.content.delete(",")
			likes = doc.xpath('//*[@id="watch8-sentiment-actions"]/span/span[1]/button/span').first.content.delete(",")
			dislikes = doc.xpath('//*[@id="watch8-sentiment-actions"]/span/span[3]/button/span').first.content.delete(",")

			joblog "Video has had " + views + " views"
			#joblog "Video has had " + likes + " likes"
			#joblog "Video has had " + dislikes + " dislikes"

			v.update(ytviews: views)

			runningtotal += views.to_i
		end
		avg = runningtotal / vids.count
		chan.update(ytvaverage: avg)
		joblog "ViewsViaNoko:\t\t" + chan.slug + "\tNew Average: " + avg.to_s
		joblog "ViewsViaNoko:\t\t" + chan.slug + "\tend"

  end
end
