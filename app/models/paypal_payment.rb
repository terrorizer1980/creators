class PaypalPayment

  def initialize(subscription)
    @subscription = subscription
  end

  def checkout_details
    joblog "checkout_details"
    process :checkout_details
  end

  def checkout_url(options)
    joblog "checkout_url"
    process(:checkout, options).checkout_url
  end

  def make_recurring_orig
    joblog "make_recurring - Step 1: request_payment"
    process :request_payment

    joblog "make_recurring - Step 2: create_recurring_profile"
    process :create_recurring_profile, period: :monthly, frequency: 1, start_at: Time.zone.now 
  end

  def request_payment
    @response = process :request_payment
    #joblog "=== request_payment ==="
    #joblog response.params
    #joblog "==="
  end

  def make_recurring
    process :create_recurring_profile, period: :monthly, frequency: 1, start_at: Time.zone.now 
  end

  def suspend
    joblog "suspend"
    process :suspend, profile_id: @subscription.paypal_recurring_profile_token
  end

  def reactivate
    joblog "reactivate"
    process :reactivate, profile_id: @subscription.paypal_recurring_profile_token
  end

  def cancel
    joblog "cancel"
    process :cancel, profile_id: @subscription.paypal_recurring_profile_token
  end

  private

  def process(action, options = {})
    options = options.reverse_merge(
      ipn_url: "https://www.101.net/admin/ppipn",
      token: @subscription.paypal_payment_token,
      payer_id: @subscription.paypal_customer_token,
      description: @subscription.paypal_subscription_description,
      amount: "%.2f" % @subscription.paypal_subscription_amount,
      currency: "USD" 
      )
    joblog "Process: Options"
    joblog options
    response = PayPal::Recurring.new(options).send(action)
    joblog "Process: Response"
    joblog response.params


    if response.errors.present?
      joblog "ERROR!"
      joblog response.errors.inspect  
      raise response.errors.inspect 
    end
    response
  end

end


=begin

Typical Response
{
  :TOKEN=>"EC-5MW94761SM807682K", 
  :SUCCESSPAGEREDIRECTREQUESTED=>"false", 
  :TIMESTAMP=>"2015-08-14T03:01:52Z", 
  :CORRELATIONID=>"7e99460c8c8ae", 
  :ACK=>"Success", 
  :VERSION=>"72.0", 
  :BUILD=>"000000", 
  :INSURANCEOPTIONSELECTED=>"false", 
  :SHIPPINGOPTIONISDEFAULT=>"false", 
  :PAYMENTINFO_0_TRANSACTIONID=>"71N60092TX420040U", 
  :PAYMENTINFO_0_TRANSACTIONTYPE=>"expresscheckout", 
  :PAYMENTINFO_0_PAYMENTTYPE=>"instant", 
  :PAYMENTINFO_0_ORDERTIME=>"2015-08-14T03:01:51Z", 
  :PAYMENTINFO_0_AMT=>"60.00", 
  :PAYMENTINFO_0_FEEAMT=>"2.04", 
  :PAYMENTINFO_0_TAXAMT=>"0.00", 
  :PAYMENTINFO_0_CURRENCYCODE=>"USD", 
  :PAYMENTINFO_0_PAYMENTSTATUS=>"Completed", 
  :PAYMENTINFO_0_PENDINGREASON=>"None", 
  :PAYMENTINFO_0_REASONCODE=>"None", 
  :PAYMENTINFO_0_PROTECTIONELIGIBILITY=>"Ineligible", 
  :PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE=>"None", 
  :PAYMENTINFO_0_SECUREMERCHANTACCOUNTID=>"MQLJ5C2NHBVUJ", 
  :PAYMENTINFO_0_ERRORCODE=>"0", 
  :PAYMENTINFO_0_ACK=>"Success"}

              :id => :integer,
            :user_id => :integer,
             :txtype => :integer,
           :currency => :integer,
          :direction => :integer,
       :amount_cents => :integer,
      :balance_cents => :integer,
     :amount_credits => :integer,
    :balance_credits => :integer,
              :notes => :string,
         :created_at => :datetime,
         :updated_at => :datetime
=end