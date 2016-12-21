require 'nokogiri'

class SubsViaNokoJob < ActiveJob::Base
  queue_as :default

  def perform(channel)
    
    chan = Channel.find_by_id(channel) 
    raw = chan.url
		
		joblog "SubsViaNoko:\t\t" + chan.slug + "\tstart"
		
		url = "https://www.youtube.com/channel/" + raw
		
		doc = Nokogiri::HTML(open(url))

		subs = doc.xpath('//*[@id="c4-primary-header-contents"]/div/span/span[1]').first.content.delete(",")
		joblog "Channel has " + subs + " subscribers"
	  
	  	old_url = nil
	  	vidlink = doc.xpath('//*[@id="channel-navigation-menu"]/li[6]/a').first['href'];
		if !vidlink.include? raw
			joblog "This channel has an old-style URL: " + vidlink
			old_url = vidlink
		end

	  chan.update(subscribers: subs, old_url: old_url)

		joblog "SubsViaNoko:\t\t" + chan.slug + "\tend"


  end
end
