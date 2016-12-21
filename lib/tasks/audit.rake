task channel_audit: :environment do
	puts "Channel Audit"
	puts "------- -----"
	active_clients.find_each do |u|
		q = u.channels.joins(:plan).merge(Plan.where("price > ?", 0)).where(subscription_id: nil)
		if q.count > 0
			s = u.subscription
			puts ""
			puts "User:\t\t\t" + u.email
			puts "Subscription ID:\t" + s.id.to_s
     	puts "Recurring Token:\t" + s.paypal_recurring_profile_token
      puts "Subscription Amount:\t" + s.paypal_subscription_amount.to_s
			puts "-----------------"
			plantotal = 0.0
			q.find_each do |c|
				p = c.plan.price
				puts (p/100).to_s + "\t" +c.name 
				plantotal += p
			end
			plantotal = plantotal / 100
			puts plantotal.to_s
			puts "-----------------"

		end
	end
end

def active_clients
  User.client.includes(:channels).where.not(channels: { id: nil })
end