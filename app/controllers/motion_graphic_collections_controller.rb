class MotionGraphicCollectionsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_motion_graphic_collection, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource  

  # GET /motion_graphic_collections
  # GET /motion_graphic_collections.json
  def index
    @motion_graphic_collections = MotionGraphicCollection.all
  end

  # GET /motion_graphic_collections/1
  # GET /motion_graphic_collections/1.json
  def show
  end

  # GET /motion_graphic_collections/new
  def new
    @motion_graphic_collection = MotionGraphicCollection.new
  end

  # GET /motion_graphic_collections/1/edit
  def edit
  end

  # POST /motion_graphic_collections
  # POST /motion_graphic_collections.json
  def create
    @motion_graphic_collection = MotionGraphicCollection.new(motion_graphic_collection_params)

    respond_to do |format|
      if @motion_graphic_collection.save
        format.html { redirect_to @motion_graphic_collection, notice: 'Motion graphic collection was successfully created.' }
        format.json { render :show, status: :created, location: @motion_graphic_collection }
      else
        format.html { render :new }
        format.json { render json: @motion_graphic_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /motion_graphic_collections/1
  # PATCH/PUT /motion_graphic_collections/1.json
  def update
    respond_to do |format|
      if @motion_graphic_collection.update(motion_graphic_collection_params)
        format.html { redirect_to @motion_graphic_collection, notice: 'Motion graphic collection was successfully updated.' }
        format.json { render :show, status: :ok, location: @motion_graphic_collection }
      else
        format.html { render :edit }
        format.json { render json: @motion_graphic_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /motion_graphic_collections/1
  # DELETE /motion_graphic_collections/1.json
  def destroy
    @motion_graphic_collection.destroy
    respond_to do |format|
      format.html { redirect_to motion_graphic_collections_url, notice: 'Motion graphic collection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_motion_graphic_collection
		@motion_graphic_collection = MotionGraphicCollection.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def motion_graphic_collection_params
		params.require(:motion_graphic_collection).permit(:name, :description, :preview, :tag_list)
    end
end
