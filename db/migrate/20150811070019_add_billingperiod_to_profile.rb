class AddBillingperiodToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :billingperiod, :integer, default: 0
    add_column :profiles, :paypal_subscription_amount, :integer
  end
end
