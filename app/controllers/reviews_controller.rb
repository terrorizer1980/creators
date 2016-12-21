class ReviewsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_channel, only: [:index, :new, :create]

  load_and_authorize_resource  

  # GET /reviews
  # GET /reviews.json
  def index
    #@reviews = Review.all
    @reviews = @channel.reviews
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    if @channel.managed?
      @review = Review.new
    else
      flash[:instruction] = 'This channel is unmanaged. Please pick a plan.' 
      redirect_to edit_channel_path(@channel) and return false
    end
  end

  # GET /reviews/1/edit
  def edit    
    @last = @review.channel.reviews.completed.last

    @staff = User.staff.all
  end

  # POST /reviews
  # POST /reviews.json
  def create
    if @channel.user.profile.advisor.nil? 
      @channel.user.profile.update!(advisor: User.staff.advisor.last)
    end
    advisor = User.find_by_id(@channel.user.profile.advisor)

    gtg     = false

    Date.tomorrow.sunday? ? slot = Date.tomorrow+1 : slot = Date.tomorrow

    until gtg == true do 
      reviewload = advisor.reviews.where(scheduled_for: slot.in_time_zone.beginning_of_day).count
      gtg = true if reviewload < 6 #TODO: Make into a constant for easy changing
      if gtg == false
        slot.saturday? ? slot +=2 : slot +=1
      end
    end

    sexyname = @channel.slug + "-" + slot.strftime('%Y-%m-%d')

    @review             = Review.new(
        channel_id:     @channel.id,
        user_id:        advisor.id,
        scheduled_for:  slot, 
        sexyname:       sexyname,
        status:         :scheduled
      )

    respond_to do |format|
      if @review.save
        format.html { redirect_to channel_reviews_path(@channel), notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    calculate_score
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
#  def destroy
#    @review.destroy
#    respond_to do |format|
#      format.html { redirect_to channel_path, notice: 'Review was successfully destroyed.' }
#      format.json { head :no_content }
#    end
#  end

  private
    def calculate_score
      @review.total_score = params[:review][:content_score].to_i + params[:review][:optimization_score].to_i + params[:review][:promotion_score].to_i + params[:review][:engagement_score].to_i
    end

    def set_review
      @review = Review.friendly.find(params[:id])
    end

    def set_channel
      @channel = Channel.friendly.find(params[:channel_id])
    end

    def review_params
      #params.require(:review).permit(:channel_id)
      params.require(:review).permit(:channel_id, :user_id, :subs, :completed_at, :scheduled_for, :status,
          :content_score,:subscribers,:channel_views,:videos,:content_notes,:optimization_score,
          :optimization_notes,:promotion_score,:promotion_notes,:engagement_score,:engagement_notes,
          :summary
        )
    end
end
