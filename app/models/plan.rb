class Plan < ActiveRecord::Base

	validates :name, uniqueness: true
  
  # NOTE THIS NEEDS TO MATCH in Profile.rb
  enum period: 
  	{ monthly: 0,
  		annual: 1
  	}

end
