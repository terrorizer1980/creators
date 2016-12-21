class RegistrationsController < Devise::RegistrationsController
  after_action :create_gift_certificate, only: :create
  after_action :send_notification, only: :create
  
  # need the devise helper to access current_user
  include Devise::Controllers::Helpers
  
  protected

    # force devise to redirect to the edit account view after update, instead of the site root
    def after_update_path_for(resource)
      edit_registration_path(resource)
    end
  
  private
  
  def send_notification
    log_to_hipchat('A new user, ' + @user.email + ' has registered for 101, on ' + Rails.env)
  end
  
  def create_gift_certificate
    ## Create a network101 welcome gift for the new user
    unless TRIAL[:gift_voucher] == nil
      GiftVoucher.transaction do
        if @user.persisted?
          gift_voucher = GiftVoucher.new (TRIAL[:gift_voucher])
          gift_voucher.to_user_id = @user.id
          gift_voucher.from_user_id = User.where(staffrole: 'admin').first.id
          # any admin will do, only from_text is shown for anonymous gifts
          gift_voucher.save!

          unless TRIAL[:gift_voucher_items] == nil
            TRIAL[:gift_voucher_items].each do |trial_item|
              gift_voucher_item = GiftVoucherItem.new(trial_item[:contents])
              gift_voucher_item.gift_voucher = gift_voucher
              gift_voucher_item.product = Product.find_by(name: trial_item[:product_name])
              gift_voucher_item.save!
            end
          end
        else
          raise ActiveRecord::Rollback
        end
      end
    end
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :refid, :recruiter)
  end

end