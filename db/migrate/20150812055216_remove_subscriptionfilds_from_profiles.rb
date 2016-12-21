class RemoveSubscriptionfildsFromProfiles < ActiveRecord::Migration
  def change
		remove_column :profiles, :paymethod, :integer
		remove_column :profiles, :billingperiod, :integer
		remove_column :profiles, :paypal_customer_token, :string
		remove_column :profiles, :paypal_recurring_profile_token, :string
		remove_column :profiles, :paypal_subscription_amount, :decimal
		remove_column :profiles, :paypal_subscription_description, :string
  end
end
