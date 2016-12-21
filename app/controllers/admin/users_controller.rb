class Admin::UsersController < AdminController
  before_action :set_user, only: [:show, :edit, :update]
  
  def index
    @users = User.all
    
#    TODO: we should support searching, sorting and filtering here

    @users = @users.includes(:profile).paginate(:page => params[:page])
  end
  
  def show
  end
    
  def edit
  end
    
  def update
  end
    
  def destroy
  end
  
  private 
  
  def set_user
    @user = User.find(params[:id])
    end
end