class Video < ActiveRecord::Base
  belongs_to :channel
  belongs_to :user
    

 	extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      :uuid
    ]
  end

  enum progress: 
  	{ 
      planning: 0,
      imported: 1
  	}
  
  delegate :user_id, to: :channel
  
  def thumbnail_best(variation = nil)
    unless thumbnail_local_url.nil?
      if variation.nil?
        thumbnail_local_url
      else
        thumbnail_local_url(variation)
      end
    else
      thumbdefault
    end
  end
  
  mount_uploader :thumbnail_local, VideoThumbnailUploader

  validates_uniqueness_of :ytvid, :scope => [:channel_id], :allow_blank => true

#  self.per_page = 15
end
