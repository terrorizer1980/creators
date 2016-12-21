class Subscription < ActiveRecord::Base
  belongs_to :user
  has_many :channels

  enum paymethod:
  {
  	paypal: 0,
  	credit_card: 1
  }

  #NOTE THIS NEEDS TO MATCH in plan.rb
  enum billingperiod:
  {
    monthly: 0,
    annual: 1
  }
  
  def paypal
    PaypalPayment.new(self)
  end


  def save_with_payment
    joblog "save_with_payment"
  end

  def save_with_payment_orig
    joblog "save_with_payment"
    if paypal_payment_token.present?
      save_with_paypal_payment
    else
      joblog "something is missing"
    end

    joblog "save_with_payment returned"
    #if valid?
    #  if paypal_payment_token.present?
    #    save_with_paypal_payment
      #else
        # credit cards in the future
    #  end
    #else joblog "invalid"
    #end
  end

  def save_with_paypal_payment
    joblog "save_with_paypal_payment"
    #response = paypal.make_recurring
    response = paypal.make_recurring
    joblog "save_with_paypal_payment returned"
    #{
    #    :PROFILEID => "I-TVV2SD9HK71T",
    #:PROFILESTATUS => "ActiveProfile",
    #    :TIMESTAMP => "2015-08-13T05:29:04Z",
    #:CORRELATIONID => "9c57f1e14f412",
    #          :ACK => "Success",
    #      :VERSION => "72.0",
    #        :BUILD => "000000"
    #}
    self.paypal_recurring_profile_token = response.profile_id
    save!
  end


  def request_paypal_payment
    joblog "subscription.rb-request_paypal_payment"
    response = paypal.request_payment
  end

  def payment_provided?
    paypal_payment_token.present?
  end

end
