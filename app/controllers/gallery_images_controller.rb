class GalleryImagesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_selected_channel
  before_action :set_gallery_image, only: [:show, :edit, :update, :destroy]
  before_action :set_user_gallery, only: [:index, :create]

  load_and_authorize_resource

  # GET /gallery_images
  # GET /gallery_images.json
  def index
    unless params['gallery_type'].blank?
      @gallery_images = current_user.user_galleries.where(gallery_type: params['gallery_type'], channel_id: @selected_channel.id).first_or_create.gallery_images
    else
      @gallery_images = @user_gallery.gallery_images
    end
    respond_to do |format|
      format.json { render :json => @gallery_images }
    end
  end

  # GET /gallery_images/1
  # GET /gallery_images/1.json
  def show
  end

  # GET /gallery_images/new
  def new
  	@gallery_image = GalleryImage.new
  end

  # GET /gallery_images/1/edit
  def edit
  end

  # POST /gallery_images
  # POST /gallery_images.json
  def create
	current_params = gallery_image_params
	@gallery_image = GalleryImage.new(current_params)
    if @user_gallery.nil?
      puts 'gallery_image is being created by type and channel'
      @gallery_image.user_gallery_id = 
        current_user.user_galleries.where(
          gallery_type: current_params[:gallery_type], 
          channel_id: @selected_channel.id)
      .first_or_create.id
    else
      @gallery_image.user_gallery = @user_gallery
      puts 'gallery_image is being created inside an existing user_gallery'
    end
      
	if @gallery_image.name.blank?
		@gallery_image.name = File.basename @gallery_image.url_url
	end

	respond_to do |format|
		if @gallery_image.save!
			format.html {  }
			format.json { render :show, status: :created, location: @gallery_image }
		else
			format.html {  }
			format.json { render json: @gallery_image.errors, status: :unprocessable_entity }
		end
	end
  end

  # PATCH/PUT /gallery_images/1
  # PATCH/PUT /gallery_images/1.json
  def update
    respond_to do |format|
      if @gallery_image.update(gallery_image_params)
        format.html { redirect_to @gallery_image, notice: 'Gallery image was successfully updated.' }
        format.json { render :show, status: :ok, location: @gallery_image }
      else
        format.html { render :edit }
        format.json { render json: @gallery_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gallery_images/1
  # DELETE /gallery_images/1.json
  def destroy
    @gallery_image.destroy
    respond_to do |format|
      format.html { redirect_to @gallery_image.user_gallery, notice: 'Gallery image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
	
  def render_gallery_dropdown
      respond_to do |format|
          format.html { render :partial => '/application/ui_gallery_dropdown', :format => 'html', :locals => { :gallery_type => params[:gallery_type], :leave_empty => params[:leave_empty], :dropdown_name => params[:dropdown_name], :class_name => params[:class_name] } }
      end
  end
	
  private
    # Use callbacks to share common setup or constraints between actions.
	def set_selected_channel
		@selected_channel = current_user.profile.selected_channel.blank? ? current_user.channels.first : current_user.profile.selected_channel
	end
	
    def set_gallery_image
      @gallery_image = GalleryImage.find(params[:id])
    end
  
    def set_user_gallery
      @user_gallery = params[:user_gallery_id].nil? ? nil : UserGallery.find(params[:user_gallery_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
	def gallery_image_params
		params.require(:gallery_image).permit(:name, :url, :gallery_type)
	end
end