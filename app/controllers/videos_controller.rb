class VideosController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_video, only: [:show, :edit, :update, :destroy]
  before_action :set_channel, only: [:index, :new, :create]

  load_and_authorize_resource  

  # GET /videos
  # GET /videos.json
  def index
    @videos = @channel.videos.paginate(:page => params[:page]).order('published_at DESC')
  end

  def ytimport
    cc = Channel.friendly.find(params[:channel_id])

    safetime = Time.now - 1.hour
    if cc.updated_at > safetime
		if (cc.created_at > safetime || Rails.env.development?)
        FetchYoutubeVideoStatsJob.perform_later cc.id
      else
        flash[:alert] = 'Please be kind to the system, and ony import once an hour.' 
        redirect_to channel_videos_path(cc) and return false  
      end 
    else
      FetchYoutubeVideoStatsJob.perform_later cc.id
    end
    
    respond_to do |format|
      if cc.touch
		format.html { redirect_to channel_videos_path(cc), notice: 'Importing. Please check back in a couple of minutes.' }
        format.js #TODO: AJAX this bitch up
      end
    end
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(video_params)
    @video.uuid = SecureRandom.uuid
    @video.user_id = current_user.id
    @video.channel_id = @channel.id

    respond_to do |format|
      if @video.save
        format.html { redirect_to channel_videos_url(@video.channel), notice: 'Video was successfully created.' }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
	  format.html { redirect_to channel_videos_url(@video.channel), notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.friendly.find(params[:id])
    end

    # woo hoo nested routes.
    def set_channel
      @channel = Channel.friendly.find(params[:channel_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:channel_id, :name, :progress)
    end
end
