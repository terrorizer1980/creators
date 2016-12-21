class ChannelsController < ApplicationController
  before_filter :authenticate_user!  
  before_action :set_channel, only: [:show, :edit, :update, :destroy]
  before_action :set_channel_plans, only: [:new, :create, :show, :edit, :update]
  load_and_authorize_resource

  include YoutubeHelper
	
  # GET /channels
  # GET /channels.json
  def index
#    if current_user.staff? && current_user.admin?
#      @channels = Channel.all.includes(:plan).includes(:reviews)
#    elsif current_user.staff? && current_user.advisor?
#      @channels = Channel.all.includes(:plan).includes(:reviews) #TODO get only currently assigned channels
#    elsif current_user.staff? && current_user.artist?
#      @channels = Channel.all.includes(:plan).includes(:reviews) #TODO get only currently assigned channels
#    else
#      if current_user.channels.nil?
#        redirect_to dashboard_path and return false
#      end
    channels = (current_user.staff? ? Channel.all : current_user.channels).includes(:plan, :reviews, :user => [{ profile: :user }])
    @managedchannels = channels.joins(:plan).merge(Plan.where("price > ?", 0)).paginate(:page => params[:page])
    @unmanagedchannels = channels.joins(:plan).merge(Plan.where("price = ?", 0)).paginate(:page => params[:page])
#    end
  end

  # GET /channels/1
  # GET /channels/1.json
  def show
  end

  # GET /channels/new
  def new
    if params[:r].nil?
      @isref = 0
      @greeting = "New Channel"
    else
      @isref = 1
      if current_user.id = params[:r]
		  @greeting = "Referral by " + User.find_by(id: params[:r]).email
      else        
		  @greeting = "Invalid referral."
      end
      #@channel = Channel.new(reffedby: current_user.id, referral: true)
    end
    @channel = Channel.new
  end

  # Will blow up if no plans exist for that period. Add seeds!
  def edit
    @reffedby = User.find_by(id: @channel.reffedby)
  end

  # POST /channels
  # POST /channels.json
  def create
    @channel = Channel.new(channel_params)
	  
	  if(@channel.platform == 'youtube')
      begin
	  	  set_raw_url
		    set_youtube_params
      rescue YoutubeError => ex
        flash[:alert] = ex.message
      end      
      # TODO: Should we warn member if someone has already added their channel?
    end
    
    # TODO: Referral logic?



	  respond_to do |format|
		  if @channel.save
        
				if(@channel.platform == 'youtube')
					create_first_review
					SubsViaNokoJob.perform_later @channel
				end

				if current_user.channels.count == 1
					current_user.profile.update!(selected_channel_id: @channel.id)
				end
		# TODO: Flag if price > 0 and redirect to /subs	
				format.html { redirect_to @channel, notice: 'Channel was successfully created.' and return true}
				format.json { render :show, status: :created, location: @channel }
			else
				format.html { render :new }
				format.json { render json: @channel.errors, status: :unprocessable_entity }
			end
		end
	end

  # PATCH/PUT /channels/1
  # PATCH/PUT /channels/1.json
  def update
	  @channel.update_attributes(channel_params)
    
      if(@channel.platform == 'youtube')
          begin
            set_raw_url
            set_youtube_params
          rescue YoutubeError => ex
            flash[:alert] = ex.message
          end
      end

	  if @channel.plan.price > 0 		# this is a paid plan
	  	@channel.update(managed: true)
        
        log_to_hipchat('User ' + current_user.email + ' has switched to a managed plan (' + @channel.plan.name + ') for the "' + @channel.name + '" channel on ' + Rails.env)
        
	  	if @channel.plan.price_was == 0 # upgrade from free
		  	if @channel.reviews.present? # this is a reactivation	  		
		  		if @channel.reviews.cancelled.present? # we cancelled something. maybe downgraded before?
			  		lastreview = reviews.cancelled.last
			  		t = Time.now - 90.days
		  			if lastreview.scheduled_for > t  		# recent downgrade. charge 'em!
		  				lastreview.update(status: "scheduled")
		  				# TODO: backdate billing for this channel
		  			else										# ok, long ago
		  				create_first_review
		  			end
		  		else 											# long ago. safe to create a review
		  			create_first_review
		  		end
		  	else												# this is new or an upgrade. Yay!
		  		create_first_review 
		  	end
		  end
	  else													# downgrading?, no soup for you!
	  	@channel.update(managed: false)
	  	cancel_pending_reviews
        log_to_hipchat('User ' + current_user.email + ' has switched to an unmanaged plan for the "' + @channel.name + '" channel on ' + Rails.env)
	  end
    
    # instead of always redirecting to @channel, check if the :redirect_path param is set
    # and redirect to that path if it is.
    if params[:redirect_path].nil?
      next_page = @channel
    else
      next_page = params[:redirect_path]
    end
    
    respond_to do |format|
  	  if @channel.save


  #TODO: flag if price change
        format.js
        format.html { redirect_to next_page, notice: 'Channel was successfully updated.' and return true}
        format.json { render :show, status: :ok, location: @channel }
      else
        format.html { render :edit }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /channels/1
  # DELETE /channels/1.json
  def destroy
    @channel.destroy
    respond_to do |format|
	  format.html { redirect_to channels_url, notice: 'Channel was successfully destroyed.' and return true}
      format.json { head :no_content }
    end
  end

  private

  def cancel_pending_reviews
  	@channel.reviews.where("status <> ?", "completed").each do |r|
  		r.update(status: "cancelled")
  	end
  end

  def create_first_review
    existingchannel = Channel.find_by(url: @rawurl)
    unless existingchannel.reffedby.present? && existingchannel.user_id.nil?
      advisor = User.find_by_id(@channel.user.profile.advisor)
      if advisor.nil?
        joblog "no advisor assigned to #{current_user.email}"
      else
        gtg = false
        Date.tomorrow.sunday? ? slot = Date.tomorrow+1 : slot = Date.tomorrow

        until gtg == true do 
          reviewload = advisor.reviews.where(scheduled_for: slot.in_time_zone.beginning_of_day).count
          gtg = true if reviewload < 6 #TODO: Make into a constant for easy changing
          if gtg == false
            slot.saturday? ? slot +=2 : slot +=1
          end
        end

        sexyname = @channel.slug.to_s + "-" + slot.strftime('%Y-%m-%d')

        Review.create(
          channel_id:     @channel.id,
          scheduled_for:  slot, 
          sexyname:       sexyname,
          user_id:        advisor.id,                 
          status:         :scheduled
          )
      end
    end
  end

  def compare_subscription_value
    unless current_user.free?
      @subscription = current_user.subscription
      @managedchannels = current_user.channels.where(managed: true).includes(:plan)
      @subsprice = 0
      @managedchannels.each do |mc|
        @subsprice += mc.plan.price
      end
      if @subscription.paypal_subscription_amount.nil?
        @spsa = "0.00"
      else
        @spsa = "%.2f" % @subscription.paypal_subscription_amount
      end
      @sp     = "%.2f" % (@subsprice / 100)

      redirect_to subscriptions_path and return false unless @sp == @spsa
    end
  end

  def set_youtube_params
    load_youtube_params(@channel, @rawurl) unless @rawurl.nil?
  end

  def set_raw_url
    @rawurl = channel_params[:url]
    unless channel_params[:url].nil?
      if @rawurl.include?("/user")
        flash[:alert] = 'Wrong Format. Please use https://www.youtube.com/channel/XXXXXXXXXXX. If you need assistance, please contact support.' 
        redirect_to new_channel_path and return false
      else
        @rawurl = sanitize_youtube_url_new(@rawurl)
      end
    end
  end      

  def set_channel_plans
    current_user.create_subscription(paymethod: "paypal", billingperiod:"monthly") if current_user.subscription.nil?
    if current_user.subscription.monthly?
      @myplans = Plan.where(available: true).monthly
    elsif current_user.subscription.annual?
      @myplans = Plan.where(available: true).annual
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_channel
    @channel = Channel.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def channel_params
    params.require(:channel).permit(:name, :url, :notes, :managed, :platform, :referral, :reffedby, :thumbuploaded, :user_id, :channel_category_id, :plan_id)
  end
end


# Check to see if the channel exists before creating
#    existingchannel = Channel.find_by(url: @rawurl)
#    if existingchannel.present?  # is it a client-created channel or a ref-created channel
#      if existingchannel.user_id.present? # ok it's a client channel
#        if channel_params[:user_id].present? # return, sorry this channel is already assigned
#          # this was a user trying to register a channel already on the system
#          if channel_params[:user_id] == current_user.id # registering own channel twice
#            flash[:alert] = 'You have already registered this channel.' 
#            redirect_to new_channel_path and return false
#          else # someone else's channel
#            flash[:alert] = 'Someone else already registered this channel on network101. Please check for typos or contact support' 
#            redirect_to new_channel_path and return false
#          end
#        else
#          # this was a recruiter going after someone already on the system
#          flash[:alert] = 'This channel is already registered on network101.' 
#          redirect_to referrals_path and return false
#        end
#      
#      elsif existingchannel.reffedby.present? && existingchannel.user_id.nil?
#        # Channel has a ref code but no user. This is a referral.
#        if current_user.refid.present?  # User has a ref code. But is it valid?
#          userrefcode = User.joins(:profile).find_by(profiles: { slug: current_user.refid })
#          if userrefcode.present? #yay, valid
#            userref = userrefcode.id
#            if userref == existingchannel.reffedby # channel referral matches user ref code. Safe.
#              redirect_to edit_channel_path(existingchannel, clarify: "match") and return false
#            else # uh oh, channel ref does not match user ref code. Throw warning.
#              redirect_to edit_channel_path(existingchannel, clarify: "nomatch") and return false
#            end
#          else  #boo, invalid user ref code. treat it like no ref code
#            redirect_to edit_channel_path(existingchannel, clarify: "invalidref") and return false
#          end
#        else # User has no ref code. Forgot? Signed up without it?
#          redirect_to edit_channel_path(existingchannel, clarify: "nouref") and return false
#        end
#      elsif existingchannel.reffedby.present? # someone else has referred it
#        flash[:alert] = 'Another recruiter is already speaking to the owner of this channel. Please try again in a month.' 
#        redirect_to referrals_path and return false
#      else
#        flash[:alert] = "Something is broken. Please inform support."
#        redirect_to dashboard_path and return false
#      end
#    end