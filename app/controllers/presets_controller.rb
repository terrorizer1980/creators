class PresetsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_preset, only: [:show, :edit, :update, :destroy]
  before_action :set_channel, only: [:index, :new, :create]

  # GET /presets
  # GET /presets.json
  def index
    @presets = @channel.presets
  end

  # GET /presets/1
  # GET /presets/1.json
  def show
    @intro      = MotionGraphic.intros.first
    @intro      ||= MotionGraphic.find(@preset.intro_template_id)
    @l3         = MotionGraphic.lower_thirds.first
    @l3         ||= MotionGraphic.find(@preset.l3_template_id)
    @background = MotionGraphic.backgrounds.first
    @background ||= MotionGraphic.find(@preset.background_template_id)
    @endcard    = MotionGraphic.end_cards.first
    @endcard    ||= MotionGraphic.find(@preset.endcard_template_id)
  end

  # GET /presets/new
  def new
    @preset = Preset.new
  end

  # GET /presets/1/edit
  def edit
  end

  # POST /presets
  # POST /presets.json
  def create
    @preset = Preset.new(preset_params)
    @preset.user_id = current_user.id
    @preset.channel_id = @channel.id
    
    respond_to do |format|
      if @preset.save
        format.html { redirect_to @preset, notice: 'Preset was successfully created.' }
        format.json { render :show, status: :created, location: @preset }
      else
        format.html { render :new }
        format.json { render json: @preset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /presets/1
  # PATCH/PUT /presets/1.json
  def update
    respond_to do |format|
      if @preset.update(preset_params)
        format.html { redirect_to @preset, notice: 'Preset was successfully updated.' }
        format.json { render :show, status: :ok, location: @preset }
      else
        format.html { render :edit }
        format.json { render json: @preset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /presets/1
  # DELETE /presets/1.json
  def destroy
    @preset.destroy
    respond_to do |format|
      format.html { redirect_to presets_url, notice: 'Preset was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    
    def set_preset
      @preset = Preset.friendly.find(params[:id])
    end

    def set_channel
      @channel = Channel.friendly.find(params[:channel_id])
    end

    def preset_params
      params.require(:preset).permit(:channel_id, :name, :intro_template_id, :customizeintropervideo, :background_template_id, :l3_template_id, :endcard_template_id)
    end
end
