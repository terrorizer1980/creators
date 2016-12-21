class Tx < ActiveRecord::Base
  belongs_to :user

  enum txtype: 
	{
		paypal_auto: 0,
		paypal_manual: 1,
		credit_card_auto: 2,
		credit_card_manual: 3,
    buy_credits: 4,
		coupon: 5,
		complimentary: 6,
    spend_credits: 7,
    expire_credits: 8,
    credit_reversal: 9
  }

  enum currency:
  {
  	usd: 0,
    credits: 1,
    transfer: 2
  }

  enum direction:
  {
  	debit: 0,
  	credit: 1,
    purchase: 2, # credit credits, debit currency
    refund: 3 # debit credits, credit currency (TODO: Refund logic)
  }

end
=begin

subscription / regular putchase -> payment notification received from webhook
  - record payment tx, run buy_credits tx
manual purchase
  - record payment tx, run buy_credits tx

payment (currency: usd, direction: credit)
  - paypal auto
  - paypal manual
  - cc auto monthly
  - cc manual

buy credits (currency: transfer, direction: purchase)
  credit credit balance
  debit payment method  Notes: associated payment tx
be given credits
  credit credit balance
  - coupon
  - complimentary (staff override)
spend credits (currency: credits, direction: debit)
  debit credit balance
  - spend_credits
expire credits (currency: credits, direction: debit)
  debit credit balance
  - expire_credits
  TODO: credit expiration task
credit reversal (currency: credits, direction: debit)
(when someone cancels before paypal dings 'em)
  debit credit balance
refund (currency: transfer, direction: refund)
  debit credit balance
  credit payment method  Notes: associated payment tx
  close account!

=end