class ChannelCategoriesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_channel_category, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /channel_categories
  # GET /channel_categories.json
  def index
    @channel_categories = ChannelCategory.all.order(:description)
  end

  # GET /channel_categories/1
  # GET /channel_categories/1.json
  def show
  end

  # GET /channel_categories/new
  def new
    @channel_category = ChannelCategory.new
  end

  # GET /channel_categories/1/edit
  def edit
  end

  # POST /channel_categories
  # POST /channel_categories.json
  def create
    @channel_category = ChannelCategory.new(channel_category_params)

    respond_to do |format|
      if @channel_category.save
        format.html { redirect_to @channel_category, notice: 'Channel category was successfully created.' }
        format.json { render :show, status: :created, location: @channel_category }
        format.js 
      else
        format.html { render :new }
        format.json { render json: @channel_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /channel_categories/1
  # PATCH/PUT /channel_categories/1.json
  def update
    respond_to do |format|
      if @channel_category.update(channel_category_params)
        format.html { redirect_to @channel_category, notice: 'Channel category was successfully updated.' }
        format.json { render :show, status: :ok, location: @channel_category }
      else
        format.html { render :edit }
        format.json { render json: @channel_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /channel_categories/1
  # DELETE /channel_categories/1.json
  def destroy
    @channel_category.destroy
    respond_to do |format|
      format.html { redirect_to channel_categories_url, notice: 'Channel category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_channel_category
      @channel_category = ChannelCategory.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def channel_category_params
      params.require(:channel_category).permit(:description)
    end
end
