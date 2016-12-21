class ApplicationController < ActionController::Base
  before_filter :configure_devise_parameters, if: :devise_controller?
  include ApplicationHelper
  helper :all
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  add_flash_types :instruction

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to dashboard_url, :alert => exception.message
  end

  def after_sign_in_path_for(resource)
    current_user.profile.nil? ? new_profile_path : dashboard_path
  end 

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
  
  protected
  
  # This allows us the update the recruiter flag from the edit account view
  def configure_devise_parameters
    devise_parameter_sanitizer.for(:account_update) << :recruiter
  end
  
  def set_credits
    @credits = current_user.txes.last.present? ? current_user.txes.last.balance_credits : 0
  end
  
  def set_gift_vouchers
    @gift_vouchers = current_user.gift_vouchers.not_claimed
    @gift_voucher_count = @gift_vouchers.present? ? @gift_vouchers.count : 0

    if current_user.txes.present?
      if current_user.txes.last.balance_credits == 0 && @gift_voucher_count == 0
        @freeloader = true
      else
        @freeloader = false
      end
    else
      if @gift_voucher_count == 0
        @freeloader = true
      else
        @freeloader = false
      end
    end
  end
end