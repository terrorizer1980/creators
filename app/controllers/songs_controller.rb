class SongsController < PublishablesController
  before_filter :authenticate_user!
  before_action :set_song, only: [:show, :edit, :update, :destroy, :get_custom_fields]
  helper_method :sort_column, :sort_direction

  load_and_authorize_resource  


  # GET /songs
  # GET /songs.json
  def index
    set_song_list
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
  end

  # GET /songs/new
  def new
    @song = Song.new
  end

  # GET /songs/1/edit
  def edit
  end

  # POST /songs
  # POST /songs.json
  def create
    @song = Song.new()
    
    set_publishable_params(params[:song], @song)
    @song.assign_attributes(song_params)
    @song.user_id = current_user.id
    set_song_product(@song)

    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: 'Song was successfully created.' }
        format.json { render :show, status: :created, location: @song }
      else
        format.html { render :new }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /songs/1
  # PATCH/PUT /songs/1.json
  def update
    
    set_publishable_params(params[:song], @song)
    @song.assign_attributes(song_params)
    
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to @song, notice: 'Song was successfully updated.' }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song.destroy
    respond_to do |format|
      format.html { redirect_to songs_url, notice: 'Song was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def get_custom_fields
      respond_to do |format|
        format.json { render :json => ''}
      end
  end

  private
  
    def sort_column
      Song.column_names.include?(params[:sort]) ? params[:sort] : 'title'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end
  
    def set_song_product(song)
      song.product_id = SongProduct.find_by(name: 'Royalty Free Music Track').id
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.friendly.find(params[:id])
    end
  
    def set_song_list
      @songs = (current_user.staff? ? Song.all.includes(:user) : Song.published.includes(:user))

      if (params[:category_id] != nil && params[:category_id] != "-1")
          @songs = @songs
            .where(category: params[:category_id].to_i)
      end
      
      @songs = @songs.order(sort_column + " " + sort_direction)
      @songs = @songs.paginate(:page => params[:page])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      params.require(:song).permit(:artist, :category, :mood, :genre, :title, :content, :content_html, :summary_html, :vidurl, :remote_thumburl_url, :publish_at, :approved)
    end
end
