class DashboardController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_credits, only: [:index]
  before_filter :set_gift_vouchers, only: [:index]
 
#  before_filter :subscription_cop

  def subscribe
    #current_user.update(clientstatus: "free")
  	@signupdate = current_user.created_at
  	@daysago = 1
  end


  def index
#    if current_user.staff?
#      @news = News.all.includes(:user).first(3)
#      @articles = Article.all.includes(:user).first(3)
#    end
    
    @channels = current_user.channels.includes(:reviews).order('LOWER(name)')
    
    if current_user.profile.present? && current_user.profile.advisor?
  		@advisor = User.find_by(id: current_user.profile.advisor)
      if @advisor.profile.present? && @advisor.profile.avatar?
		@advisoravatar = @advisor.profile.avatar_url(:sidebar)
      else
        @advisoravatar = "/images/unknown-person1.gif"
      end
    else
	  @advisor = nil
	end

	if current_user.profile.present? && current_user.profile.artist?
	  @artist = User.find_by(id: current_user.profile.artist)
	  if @artist.profile.present? && @artist.profile.avatar?
		@artistavatar = @artist.profile.avatar_url(:sidebar)
	  else
		@artistavatar = "/images/unknown-person1.gif"
	  end
	else
	  @artist = nil
	end

    # Onboard
    @steps = 4
    @obstep = 1

    if current_user.profile.present?
      @obstep +=1 
      if @channels.present?
        @obstep +=1
        if current_user.profile.onboarded
          @obstep +=1
        end
      end  
   end
  end
  
  def news
    @news = (current_user.staff? ? News.all.includes(:user) : News.published.includes(:user)).first(3)
    
    respond_to do |format|
      format.html { render :partial => 'publishable_feed', :format => 'html', :locals => {feed_publishables: @news, feed_publishable_class: News} }
    end
  end
  
  def articles
    @articles = (current_user.staff? ? Article.all.includes(:user) : Article.published.includes(:user)).first(3)
    
    respond_to do |format|
      format.html { render :partial => 'publishable_feed', :format => 'html', :locals => {feed_publishables: @articles, feed_publishable_class: Article} }
#      format.html { render :partial => 'articles', :format => 'html', :locals => {} }
    end
  end
  
  def finish_onboarding
    if current_user.profile.present?
      current_user.profile.onboarded = true;
      next_path = dashboard_path
      if defined? params[:dest]
        case params[:dest]
          when 'mg'
            next_path = motion_graphics_path
          when 'apps'
            next_path = apps_path
          when 'art'
            next_path = articles_path
          end
      end

      respond_to do |format|
        if current_user.profile.save
          format.html { redirect_to next_path }
        else
          format.html { render dashboard_path, alert: 'Could not update profile. Please contact support.' }
        end
      end
    end
  end

  def cancellation
  end

  def reviews
    r = Review.includes(:user)
    @overdue = r.overdue
    @duetoday = r.duetoday
    @duenwd = r.duenwd
  end

  private
    # Ensure the amount purchased matches the subscription
    def subscription_cop
      subsprice = 0
      
      current_user.channels.where(managed: true).includes(:plan).each do |mc|
        subsprice += mc.plan.price
      end

      @sp    =   "%.2f" % (subsprice / 100)
      @spsa  =   "0.00"      
      @spsa  ||= "%.2f" % current_user.subscription.paypal_subscription_amount
      
      # Maybe Harv wants a kinder and gentler version. Not me :)
      redirect_to subscriptions_path unless @sp == @spsa
    end
  
end