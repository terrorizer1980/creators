module Purchasable
  extend ActiveSupport::Concern
  
  include ApplicationHelper
  
  ## Purchasable assumes the following fields:
  ##    product_id
  ##    title
  
  included do
    belongs_to :product
    has_many :order_items, :as => :purchasable
  end
  
  module ClassMethods
      
  end
end