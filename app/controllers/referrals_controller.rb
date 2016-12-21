class ReferralsController < ApplicationController
  include ReferralsHelper
  before_filter :authenticate_user!
  before_action :set_referral, only: [:show, :edit, :update, :increment_status, :decrement_status, :destroy]

  load_and_authorize_resource  
  
  include YoutubeHelper

  # GET /referrals
  # GET /referrals.json
  def index
	  @referrals = current_user.referrals.paginate(:page => params[:page])
  end

  # GET /referrals/1
  # GET /referrals/1.json
  def show
  end

  # GET /referrals/new
  def new
    @referral = Referral.new
  end

  # GET /referrals/1/edit
  def edit
  end

  # POST /referrals
  # POST /referrals.json
  def create
    @referral = Referral.new(referral_params)
	@referral.user_id = current_user.id
    
    if @referral.channel_type == 'youtube'
        @referral.channel_id = sanitize_youtube_url(referral_params[:channel_id])
    end
    respond_to do |format|
      if @referral.save
        format.html { redirect_to referrals_url, notice: 'Referral was successfully created.' }
        format.json { render :show, status: :created, location: @referral }
      else
        format.html { render :new }
        format.json { render json: @referral.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /referrals/1
  # PATCH/PUT /referrals/1.json
  def update
    
    rp = referral_params
    if rp[:channel_type] == 'youtube'
      rp[:channel_id] = sanitize_youtube_url(rp[:channel_id])
    end
    
    respond_to do |format|
      if @referral.update(rp)
		format.html { redirect_to referrals_url, notice: 'Referral was successfully updated.' }
		format.json { render json: { referral: @referral, curr_status: @referral.status.humanize, next_status: incrementEnum(@referral.status, Referral.statuses), prev_status: decrementEnum(@referral.status, Referral.statuses)}, status: :ok}
      else
        format.html { render :edit }
        format.json { render json: @referral.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /referrals/1
  # DELETE /referrals/1.json
  def destroy
    @referral.destroy
    respond_to do |format|
      format.html { redirect_to referrals_url, notice: 'Referral was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def increment_status
    @referral.status = incrementEnum(@referral.status, Referral.statuses)
    respond_to do |format|
      if @referral.save
        format.html { redirect_to referrals_url, notice: 'Referral was successfully updated.' }
        format.json { render json: { curr_status: @referral.status.humanize, curr_color: get_referral_status_color(@referral.status) }, status: :ok}
      else
        format.html { render :edit }
        format.json { render json: @referral.errors, status: :unprocessable_entity }
      end
    end
  end

  def decrement_status
    @referral.status = decrementEnum(@referral.status, Referral.statuses)
    respond_to do |format|
      if @referral.save
        format.html { redirect_to referrals_url, notice: 'Referral was successfully updated.' }
        format.json { render json: { curr_status: @referral.status.humanize, curr_color: get_referral_status_color(@referral.status) }, status: :ok}
      else
        format.html { render :edit }
        format.json { render json: @referral.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_referral
		@referral = Referral.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def referral_params
		params.require(:referral).permit(:name, :email, :channel_type, :channel_id, :status, :notes, :user_id)
    end
end