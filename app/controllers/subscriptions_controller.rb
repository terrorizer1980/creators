class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_subscription, only: [:edit, :update, :destroy]

  load_and_authorize_resource

  #STEP 1
  def index
    current_user.create_subscription(paymethod: "paypal", billingperiod:"monthly") if current_user.subscription.nil?
    @subscription = current_user.subscription

    if current_user.subscription.paypal_recurring_profile_token.present?
      @paypalinfo = PayPal::Recurring.new(profile_id: current_user.subscription.paypal_recurring_profile_token).profile.params      
      if @paypalinfo[:STATUS] == "Cancelled"
        joblog 'paypal says this subscription is already cancelled!!'
        @subscription.update( paypal_recurring_profile_token: nil,
                              next_billing_date: nil)
        @paypalinfo = nil
        cancel_services
      else
        @subscription.update(last_payment_date: @paypalinfo[:LASTPAYMENTDATE],
                             next_billing_date: @paypalinfo[:NEXTBILLINGDATE]
                            )
        @daysremaining  = (@subscription.next_billing_date - DateTime.now).to_i / 86400 if @subscription.next_billing_date
        resubcredit     = @subscription.paypal_subscription_amount * (@daysremaining.to_f / 30)
        @subscription.update(resubcredit: resubcredit)
      end
    end
    @myplans = Plan.where(available: true).monthly
    
    @managedchannels   = current_user.channels.joins(:plan).merge(Plan.where("price > ?", 0))
    @unmanagedchannels = current_user.channels.joins(:plan).merge(Plan.where("price = ?", 0)) 
    
    @subsprice          = 0
    @subsreviews        = 0
    @subscredits        = 0
    @managedchannels.includes(:plan).each do |mc|
      @subsprice += mc.plan.price
      @subsreviews += 1 if mc.plan.includes_review? 
      @subscredits += mc.plan.credits
    end
    if @subscription.paypal_subscription_amount.nil?
      @spsa = "0.00"
    else
      @spsa = "%.2f" %  @subscription.paypal_subscription_amount
    end
    @sp = "%.2f" % (@subsprice / 100)
    
    @channel_update_redirect_path = subscriptions_path
  end

  #STEP 2
  def paypal_checkout
    current_user.create_subscription(paymethod: "paypal", billingperiod:"monthly") if current_user.subscription.nil?
    @subscription = current_user.subscription

    ppsa = params[:p].to_f  / 100
    ppsd = "network101: #{params[:c]} managed channels, billed #{@subscription.billingperiod}"
    @subscription.update(paypal_subscription_description: ppsd, paypal_subscription_amount: ppsa)
     redirect_to @subscription.paypal.checkout_url(
      return_url:   edit_subscription_url(id: current_user.subscription.id),
      cancel_url:   dashboard_url,
      description:  ppsd,
      amount:       ppsa,
      currency:     "USD"
    )
  end

  #STEP 3 - REDIRECT TO PAYPAL

  #STEP 4 - REPLY FROM PAYPAL
  def edit
    if params[:PayerID]
      @subscription.paypal_customer_token = params[:PayerID]
      @subscription.paypal_payment_token = params[:token]
      @subscription.save!
      @details = @subscription.paypal.checkout_details
      current_user.profile.update(paypal: @details.email) 
    end
  end

  #STEP 5
  #CONFIRM AND CONTINUE
  def update
    joblog "subscriptions/update"
    response = @subscription.request_paypal_payment

    creditbalance = 0

    if User.find(@subscription.user_id).txes.exists?
      lasttx = User.find(@subscription.user_id).txes.last 
      creditbalance += lasttx.balance_credits
    end

    begin
      Tx.create(user_id: @subscription.user_id,
              txtype: "paypal_auto",
              currency: "usd",
              direction: "credit",
              amount_cents: response.params[:PAYMENTINFO_0_AMT].to_i * 100,
              balance_cents: response.params[:PAYMENTINFO_0_AMT].to_i * 100,
              amount_credits: 0,
              balance_credits: creditbalance,
              notes: response.params[:PAYMENTINFO_0_TRANSACTIONID]
      )
      credits = response.params[:PAYMENTINFO_0_AMT].to_i / 30 * 1000 
      #TODO: Need to store included credits in subscription
      Tx.create(user_id: @subscription.user_id,
              txtype: "buy_credits",
              currency: "usd",
              direction: "purchase",
              amount_cents: response.params[:PAYMENTINFO_0_AMT].to_i * 100,
              balance_cents: 0,
              amount_credits: credits,
              balance_credits: creditbalance + credits,
              notes: response.params[:PAYMENTINFO_0_TRANSACTIONID]
      )
    end

    if @subscription.save_with_paypal_payment
      joblog "save_with_payment returned successfully"
      begin
        current_user.premium!
        @managedchannels   = current_user.channels.joins(:plan).merge(Plan.where("price > ?", 0))
        @managedchannels.each do |mc|
          # add to subscription
          mc.update(subscription_id: current_user.subscription.id)
          # restore any cancelled reviews
          lr = mc.reviews.last
          if lr.cancelled? && lr.scheduled_for > (Date.today - 30.days)
            lr.scheduled!
          end
        end
      end
      redirect_to subscriptions_path, notice: 'Subscription was successfully updated.' 
    else
      joblog "save_with_payment returned BROKEN"
      render :edit, notice: 'something broke. check joblog'
    end
  end


  def paypal_cancel
    @subscription = current_user.subscription
    ppr = PayPal::Recurring.new({
      :profile_id => current_user.subscription.paypal_recurring_profile_token
      })
    response = ppr.cancel
    joblog "paypal cancellation response: #{response.params}"
    if response.valid?
      
      cancel_services
      redirect_to subscriptions_path, notice: 'Old Subscription was successfully Cancelled'

    else
      raise response.errors.inspect
    end
  end

  def show
    redirect_to subscriptions_path
  end

  private

    def cancel_services
      if @subscription.last_payment_date.nil? 
        # fast unsubscribe - never paid. cancel everything!
        lasttx = User.find(@subscription.user_id).txes.last 
        Tx.create(user_id: @subscription.user_id,
              txtype: "credit_reversal",
              currency: "credits",
              direction: "debit",
              amount_cents: 0,
              balance_cents: 0,
              amount_credits: lasttx.balance_credits,
              balance_credits: 0,
              notes: "Cancelled Before Payment Received"
        )
        #if had at least one review (demo / gift)
        if current_user.reviews.count > 1
          reviewpendingchannels = @channels.joins(:reviews).merge(Review.where("status < ?", 3))
          reviewpendingchannels.each do |c|
            c.reviews.each.cancelled!
          end
        end
      end

      # regular unsub
      begin
        current_user.channels.each do |c|
          c.update(subscription_id: nil)
          
          if c.reviews.last.scheduled? && current_user.subscription.next_billing_date.present? && c.reviews.last.scheduled_for > current_user.subscription.next_billing_date
            # still do a review if it's scheduled before the next_billing_date
            c.reviews.last.cancelled!
          end
        end
        current_user.subscription.update(
          paypal_recurring_profile_token: nil, 
          paypal_payment_token: nil,
          paypal_subscription_amount: nil,
          next_billing_date: nil)  
        current_user.free!      
      end
    end
    
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subscription_params
      params.require(:subscription).permit(:user_id, :paymethod, :billingperiod, :paypal_customer_token, :paypal_recurring_profile_token, :paypal_subscription_amount, :paypal_subscription_description, :paypal_payment_token)
    end
end

