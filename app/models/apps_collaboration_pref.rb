class AppsCollaborationPref < ActiveRecord::Base
  belongs_to :channel

  scope :active, 		-> { where(active: true) }
  scope :inactive, 	-> { where(active: [false, nil]) }

end
