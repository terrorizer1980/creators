class Review < ActiveRecord::Base
  belongs_to :channel
  belongs_to :user

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      :sexyname
    ]
  end


  enum status: 
  	{ requested: 		0,
  		scheduled: 		1,
  		in_progress: 	2,
  		completed: 		3,
  		cancelled: 		4
  }

  scope :incomplete, 	-> { where("status < ?", 3)}
  scope :overdue, 		-> { incomplete.where("scheduled_for < ?", Date.today.beginning_of_day)}
  scope :duetoday,		-> { incomplete.where(scheduled_for: Date.today.beginning_of_day)}
  scope :duenwd,			-> { Date.tomorrow.sunday? ? incomplete.where(scheduled_for: Date.tomorrow.beginning_of_day) : incomplete.where(scheduled_for: Date.tomorrow.beginning_of_day)}
end
