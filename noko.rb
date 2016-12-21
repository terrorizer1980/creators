require 'nokogiri'
require 'open-uri'


doc = Nokogiri::HTML(open("https://www.youtube.com/channel/UCHdos0HAIEhIMqUc9L3vh1w"))
#subs = doc.xpath("//span.yt-subscription-button-subscriber-count-branded-horizontal.yt-uix-tooltip")

doc.xpath('//*[@id="c4-primary-header-contents"]/div/span/span[1]').each do |link|
	puts link.content
end


