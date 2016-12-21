class AppsController < ApplicationController
	before_filter :authenticate_user!
	before_action :set_selected_channel	

  def index
  	authorize! :index, @apps
  end

  def collaboration
  	authorize! :show, @apps
  	@cc = current_user.channels.joins(:apps_collaboration_pref).order(:slug)
	  @nc = current_user.channels.where(platform: 'youtube').includes(:apps_collaboration_pref).where(apps_collaboration_prefs: {id: nil})
  end

  def collab_matches
  	@channel = Channel.first
  end

  def collab_activate_channel
  	cc = Channel.find_by_id(collab_activate_params[:id])
  	#lastupdate =  cc.videos.last.updated_at.to_s
  	#if cc.videos.last.present? && lastupdate > Time.now.yesterday
 # if last update was less than one day ago, skip!
  	FetchYoutubeVideoStatsJob.perform_later cc
  	SubsViaNokoJob.perform_later cc
  	ViewsViaNokoJob.perform_later cc
  	# end
  	respond_to do |format|
  		if cc.apps_collaboration_pref.update!(active: true)
  			format.html { redirect_to action: 'collaboration' }
  			format.js #TODO: AJAX this bitch up
  		end
  	end
  end

  def collab_disable_channel
  	cc = Channel.find_by_id(collab_activate_params[:id])
  	respond_to do |format|
  		if cc.apps_collaboration_pref.update!(active: false)
  			format.html { redirect_to action: 'collaboration' }
  			format.js #TODO: AJAX this bitch up
  		end
  	end
  end

  def collab_init_channel
  	cc = Channel.find_by_id(collab_activate_params[:id])
	  if cc.platform == 'youtube'
		FetchYoutubeVideoStatsJob.perform_later cc
		SubsViaNokoJob.perform_later cc
		ViewsViaNokoJob.perform_later cc
		respond_to do |format|
			if cc.create_apps_collaboration_pref(active: true)
				format.html { redirect_to action: 'collaboration' }
				format.js #TODO: AJAX this bitch up
			end
		end
	  else
		  flash[:alert] = 'Sorry, you cannot initiallize non-YouTube channels.'
		  respond_to do |format|
			  format.html { redirect_to action: 'collaboration' }
			  format.js #TODO: AJAX this bitch up
		end
	  end
  end

  def thumbnail
  	#set_gallery_images
    unless params[:v].nil?
      @vid = Video.find(params[:v])
      unless @vid.nil?
        if current_user.profile.selected_channel_id != @vid.channel_id
          current_user.profile.update(selected_channel_id: @vid.channel_id)
          @selected_channel = current_user.selected_channel
          flash[:notice] = 'Selected channel changed.'
        end
      end
    end
    
    set_thumbnail_presets
    set_title
  end
	
	def thumbnail_preset_save
		authorize! :show, @apps
		
		@thumbnail_preset_new = @selected_channel.thumbnail_presets.find_by_name(thumbnail_preset_params[:name])
		
		if @thumbnail_preset_new == nil
			@thumbnail_preset_new = ThumbnailPreset.new(thumbnail_preset_params)
			@thumbnail_preset_new.channel_id = @selected_channel.id
		else
			@thumbnail_preset_new.update_attributes(thumbnail_preset_params)
		end
		
		respond_to do |format|
        	if @thumbnail_preset_new.save!
				format.html { redirect_to action: 'thumbnail', notice: 'Thumbnail preset was successfully created.' }
          		format.json { render :show, status: :created, location: 'thumbnail' }
        	else
          		format.html { render :new }
          		format.json { render json: @thumbnail_preset_new.errors, status: :unprocessable_entity }
        	end
      	end
	end
	
	def thumbnail_preset_delete
		current_thumbnail_preset = @selected_channel.thumbnail_presets.find_by_name(params[:name]);
		current_thumbnail_preset.destroy
			
		respond_to do |format|
			format.json { render :json => { status: :deleted, location: 'thumbnail' } }
		end
	end
	
	def get_thumbnail_preset_list
#		authorize! :get_thumbnail_preset_list
		respond_to do |format|
			format.json { render :json => current_user.profile.selected_channel.thumbnail_presets, :except => [:content] }
		end
	end
	
	def get_thumbnail_preset
		respond_to do |format|
			format.json { render :json => current_user.profile.selected_channel.thumbnail_presets.find_by_name(params[:name]).content }
		end
	end

private

    # Use callbacks to share common setup or constraints between actions.
	def set_thumbnail_presets
		@thumbnail_preset_new = ThumbnailPreset.new()
		
		# authorize! :get_thumbnail_preset_list, nil
		
		unless @selected_channel == nil
			@current_thumbnail_presets = @selected_channel.thumbnail_presets
		else
			@current_thumbnail_presets = nil
		end
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def gallery_image_params
		params.require(:gallery_image).permit(:name, :url, :gallery_type)
	end
	
	def thumbnail_preset_params
		params.require(:thumbnail_preset).permit(:name, :content)
	end
	
	def set_selected_channel
		@selected_channel = current_user.profile.selected_channel.blank? ? current_user.channels.first : current_user.profile.selected_channel
	end
	
	def collab_activate_params
		params.permit(:id)
	end

	def set_title
		@title = 'Thumbnail Creator - network101 apps'
	end

end