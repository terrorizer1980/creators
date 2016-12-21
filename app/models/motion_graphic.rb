class MotionGraphic < ActiveRecord::Base
#  acts_as_taggable

  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :motion_graphic_collection
  
  include Publishable
  include Purchasable
  
  enum category: 
	{
		intros: 0,
  		lower_thirds: 1,
  		backgrounds: 2,
  		end_cards: 3,
		title_cards: 4,
        countdowns: 5
  	}
  
  # Set number of items per page for will_paginate
  # It's grid view, so 6 is good
  self.per_page = 6

end
