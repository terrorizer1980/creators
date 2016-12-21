class ProfilesController < ApplicationController
  include ProfilesHelper
  before_filter :authenticate_user!
  before_action :set_profile, only: [:show, :edit, :update]

  load_and_authorize_resource  

  # GET /profiles
  # GET /profiles.json
  def index
    redirect_to profile_path(current_user)
  end

  def sub
     @profile = Profile.first
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @flag = @profile.country_code + " flag" unless @profile.country_code.nil?

    if @profile.user_id == current_user.id
      @title = "My Profile Card"
    else
      @title = "#{@profile.nickname}'s Profile Card"
    end
  end


  # GET /profiles/new
  def new
    if current_user.profile.nil?
      @profile = Profile.new
    else
      redirect_to edit_profile_path(current_user.profile.slug)
    end
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /ProfilesController
  # POST /profiles.json
  def create
    @profile                = Profile.new(profile_params)
    @profile.user_id        = current_user.id
    
    
    @profile.artist = find_preferred_artist_id
    @profile.advisor = find_preferred_advisor_id

    respond_to do |format|
      if @profile.save
        current_user.update(clientstatus: "free")
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update 
    if params[:profile][:paypal_payment_token].present?
      if @profile.update_with_payment
        redirect_to @profile, notice: 'Payment was successfully updated.'
      else
        joblog params[:profile]
       redirect_to @profile, warning: 'something broke'
      end
    else
      respond_to do |format|
        if @profile.update(profile_params)
          format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
          format.json { render json: @profile.id, status: :ok }
        else
          format.html { render :edit }
          format.json { render json: @profile.errors, status: :unprocessable_entity }
        end
      end
#      if @profile.update(profile_params)
#        redirect_to @profile, notice: 'Profile was successfully updated.'
#      else
#       render :edit, warning: 'something dun fucked up'
#      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
		params.require(:profile).permit(:user_id, :fname, :lname, :birthday, :nickname, :paypal, :recruitertos, :skype, :country_code, :bio, :avatar, :selected_channel_id)
    end

end
