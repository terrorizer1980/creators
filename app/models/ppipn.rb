class Ppipn < ActiveRecord::Base
	serialize :params

	after_create :reconcile

	private

	def reconcile  # do something more intersting later
		joblog "got something from PayPal"
		#log_to_hipchat(params)
	end
end
