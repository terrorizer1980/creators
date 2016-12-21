class PagesController < ApplicationController

	# this is the public static pages controller.

	def index
		@title = "network101 - Blog Index"
    @descr = "So content marketing is king? Fine! We'll have a blog."
	end
	
  def home
  end

  def manifesto
  	@title = "network101 - the MCN Manifesto"
    @descr = "Youtube Content Creators don't need an MCN to be successful. Here's why."
  end

  def free_blogs
  	@title = "Free Wordpress Blogs for Creators"
    @descr = "Amp up your YouTube channel with a free WordPress blog from network101"
  end
end

