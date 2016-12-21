class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    
    if user.admin? && user.staff?
      # TODO: At some point we should make this WAY more specific
      #       We won't want all staff managing all objects
      can :manage, :all
    elsif (user.client? && user.cancelled?) || (user.staff? && user.terminated?)
  		can :read, :dashboard
  		cannot :read, :all
    else
      can :read, :all
      
      ## I have reverted to the old code for now, so we can still deploy to prod for critical fixes.
      ## The more recent stuff is included below, commented out
      ## Suggest stepping through the routes file checking for custom actions
      ## Test it thoroughly before committing, then I'll do a retest
      ## We can push it up to prod when we're both satisfied it's solid.
      
      # TODO: This probably needs a bit of cleanup
      #       It might not be efficient to start with :read, :all
      cannot :read, Ppipn
      cannot :read, Channel
      cannot :read, Video
      cannot :read, UserGallery
      cannot :read, GalleryImage
      cannot :read, Referral
      cannot :read, Subscription
      cannot :read, ThumbnailPreset
      cannot :read, Order
      cannot :read, OrderItem
      cannot :read, GiftVoucher
      cannot :read, GiftVoucherItem
      
  	  can [:create, :read, :update, :destroy],  			Channel, user_id: user.id
      can [:read, :ytimport],                               Video, user_id: user.id, progress: 'imported'
      can [:create, :read, :update, :destroy, 
        :ytimport],                                         Video, user_id: user.id, progress: 'planning'
      can [:create, :read, :destroy, 
           :render_gallery_dropdown],                       UserGallery, user_id: user.id
      can [:create],                                        GalleryImage
      can [:read, :destroy],                                GalleryImage, :user_gallery => { :user_id => user.id }
      can [:create, :read, :update, :destroy],  			ThumbnailPreset, user_id: user.id
      can [:create, :read, :update, :destroy,
           :decrement_status, :increment_status],  			Referral, user_id: user.id
      can [:create, :read, :update],                        Profile, user_id: user.id
      can [:create, :read, :update],            			Request, user_id: user.id
      can [:create, :read],                     			Review, user_id: user.id
      can [:create, :read, :update, 
           :paypal_checkout, :paypal_cancel],               Subscription, user_id: user.id
      can [:create, :read, :update, :destroy, 
           :purchase_items, :clear_gift_voucher],           Order, user_id: user.id
      can [:create, :read, :update, :destroy, 
           :add_to_basket, :add_to_wishlist],  			    OrderItem, user_id: user.id
      can [:read],  			                            GiftVoucher, to_user_id: user.id
#      can [:read],  			                            GiftVoucherItem, gift_voucher.user_id: user.id
      can [:read, :get_custom_fields],                      MotionGraphic
      can [:read, :get_custom_fields],                      Song
      
      cannot :manage, Plan
      cannot :manage, Product
      cannot :manage, MotionGraphicCollection
      cannot :manage, ChannelCategory
      cannot :manage, Tx
      can :read, Tx, user_id: user.id
      
      ## ** More recent WIP code follows:
      
      #The ability rules further down in a file will override a previous one. 
      #For example, let's say we want the user to be able to do everything to projects except destroy them. 
      #This is the correct way:
      # can :manage, Project
      # cannot :destroy, Project
      
      # Further reading: https://github.com/ryanb/cancan/wiki/Ability-Precedence
      
#      cannot :read, :all
#      
#      #can :read, :dashboard
#      can :read, Article
#      can :read, @apps
#      can :read, MotionGraphic
#      can :read, News
#      can :read, Song
#      can [:create, :read, :update, :destroy],     Channel, user_id: user.id
#      can [:create, :read, :update, :destroy
#            :render_gallery_dropdown],             GalleryImage, user_id: user.id
#      can :read,                                   GiftVoucher, user_id: user.id
#      can :read,                                   GiftVoucherItem, user_id: user.id
#      can [:create, :read, :update, :destroy, 
#           :purchase_items, :clear_gift_voucher],  Order, user_id: user.id
#      can [:create, :read, :update, :destroy, 
#           :add_to_basket, :add_to_wishlist],      OrderItem, user_id: user.id
#      can [:create, :read, :update],               Profile, user_id: user.id
#      can :read,                                   Profile #TODO: https://github.com/CanCanCommunity/cancancan/wiki/FriendlyId-support
#      can [:create, :read, :update, :destroy],     Referral, user_id: user.id
#      can [:create, :read, :update],               Request, user_id: user.id
#      can [:create, :read],                        Review, user_id: user.id
#      can [:create, :read, :update, 
#           :paypal_checkout, :paypal_cancel],      Subscription, user_id: user.id
#      can [:create, :read, :update, :destroy],     ThumbnailPreset, user_id: user.id
#
#      can [:read, :ytimport],                      Video, user_id: user.id, progress: 'imported'
#      can [:create, :read, :update, :destroy, 
#        :ytimport],                                Video, user_id: user.id, progress: 'planning'
    end
    
  end
end
