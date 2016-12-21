class AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_admin
  
  layout 'admin'
  
  private
  
  def check_admin
    unless current_user.admin?
      respond_to do |format|
        format.html { redirect_to dashboard_path, alert: 'You do not have permission to access the admin area.' }
      end  
    end
  end
end