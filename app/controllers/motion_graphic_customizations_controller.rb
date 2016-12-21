class MotionGraphicCustomizationsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_motion_graphic_customization, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource  

  # GET /motion_graphic_customizations
  # GET /motion_graphic_customizations.json
  def index
    @motion_graphic_customizations = MotionGraphicCustomization.all
  end

  # GET /motion_graphic_customizations/1
  # GET /motion_graphic_customizations/1.json
  def show
  end

  # GET /motion_graphic_customizations/new
  def new
	  unless(params[:motion_graphic].blank?)
		@motion_graphic = MotionGraphic.friendly.find(params[:motion_graphic])
	  end
	  @motion_graphic_customization = MotionGraphicCustomization.new
  end

  # GET /motion_graphic_customizations/1/edit
  def edit
  end

  # POST /motion_graphic_customizations
  # POST /motion_graphic_customizations.json
  def create
    @motion_graphic_customization = MotionGraphicCustomization.new(motion_graphic_customization_params)

    respond_to do |format|
      if @motion_graphic_customization.save
        format.html { redirect_to @motion_graphic_customization, notice: 'Motion graphic customization was successfully created.' }
        format.json { render :show, status: :created, location: @motion_graphic_customization }
      else
        format.html { render :new }
        format.json { render json: @motion_graphic_customization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /motion_graphic_customizations/1
  # PATCH/PUT /motion_graphic_customizations/1.json
  def update
    respond_to do |format|
      if @motion_graphic_customization.update(motion_graphic_customization_params)
        format.html { redirect_to @motion_graphic_customization, notice: 'Motion graphic customization was successfully updated.' }
        format.json { render :show, status: :ok, location: @motion_graphic_customization }
      else
        format.html { render :edit }
        format.json { render json: @motion_graphic_customization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /motion_graphic_customizations/1
  # DELETE /motion_graphic_customizations/1.json
  def destroy
    @motion_graphic_customization.destroy
    respond_to do |format|
      format.html { redirect_to motion_graphic_customizations_url, notice: 'Motion graphic customization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_motion_graphic_customization
      @motion_graphic_customization = MotionGraphicCustomization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def motion_graphic_customization_params
      params.require(:motion_graphic_customization).permit(:user_id, :motion_graphic_id, :custom_field_data)
    end
end
