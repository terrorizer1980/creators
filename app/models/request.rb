class Request < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel

  enum reqtype: {
    advisor: 1,
    artist: 2,
    my_account: 3
  }

  enum status: 
	{ open: 0,
    in_progress: 1,
    client_review: 2,
    accepted: 3,
    modification_required: 4,
    cancelled: 5
	}
end
