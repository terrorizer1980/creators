class UserGalleriesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_selected_channel
  before_action :set_user_gallery, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource

  # GET /user_galleries
  # GET /user_galleries.json
  def index
	if current_user.admin?
		@user_galleries = UserGallery.all
	else
      @user_galleries = current_user.user_galleries.includes(:channel)
    end
  end

  # GET /user_galleries/1
  # GET /user_galleries/1.json
  def show
  end

  # GET /user_galleries/new
  def new
    @user_gallery = UserGallery.new
  end

  # GET /user_galleries/1/edit
  def edit
  end

  # POST /user_galleries
  # POST /user_galleries.json
  def create
    @user_gallery = UserGallery.new(user_gallery_params)
	@user_gallery.user_id = current_user.id

    respond_to do |format|
      if @user_gallery.save
        format.html { redirect_to @user_gallery, notice: 'User gallery was successfully created.' }
        format.json { render json: @user_gallery, status: :created }
      else
        format.html { render :new }
        format.json { render json: @user_gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_galleries/1
  # PATCH/PUT /user_galleries/1.json
  def update
    respond_to do |format|
      if @user_gallery.update(user_gallery_params)
        format.html { redirect_to @user_gallery, notice: 'User gallery was successfully updated.' }
        format.json { render json: @user_gallery, status: :updated }
      else
        format.html { render :edit }
        format.json { render json: @user_gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_galleries/1
  # DELETE /user_galleries/1.json
  def destroy
    @user_gallery.destroy
    respond_to do |format|
      format.html { redirect_to user_galleries_url, notice: 'User gallery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def render_gallery_dropdown
      respond_to do |format|
        format.html { render :partial => 'ui_gallery_dropdown', :format => 'html', :locals => { :gallery_type => params[:gallery_type], :leave_empty => params[:leave_empty], :dropdown_name => params[:dropdown_name], :class_name => params[:class_name] } }
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
	def set_selected_channel
		@selected_channel = current_user.profile.selected_channel.blank? ? current_user.channels.first : current_user.profile.selected_channel
	end
	
    def set_user_gallery
      @user_gallery = UserGallery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_gallery_params
		params[:user_gallery].allow(:user_id, :gallery_type, :channel_id)
    end
end