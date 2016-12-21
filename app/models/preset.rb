class Preset < ActiveRecord::Base

	extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :channel
  belongs_to :user
end
