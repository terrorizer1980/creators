class AddPaypalToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :paypal_customer_token, :string
    add_column :profiles, :paypal_recurring_profile_token, :string
  end
end
