class NewsController < PublishablesController  
  before_filter :authenticate_user!
  before_action :set_news, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource


  # GET /news
  # GET /news.json
  def index
    set_news_list
  end

  # GET /news/1
  # GET /news/1.json
  def show
  end

  # GET /news/new
  def new
    @news = News.new
  end

  # GET /news/1/edit
  def edit
  end

  # POST /news
  # POST /news.json
  def create
    
    @news = News.new()
    
    set_publishable_params(params[:news], @news)
    
    @news.assign_attributes(news_params)
    @news.user_id = current_user.id

    respond_to do |format|
      if @news.save
        format.html { redirect_to @news, notice: 'News was successfully created.' }
        format.json { render :show, status: :created, location: @news }
      else
        format.html { render :new }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news/1
  # PATCH/PUT /news/1.json
  def update
    
    set_publishable_params(params[:news], @news)
    
    @news.assign_attributes(news_params)
    
    respond_to do |format|
      if @news.save
        format.html { redirect_to @news, notice: 'News was successfully updated.' }
        format.json { render :show, status: :ok, location: @news }
      else
        format.html { render :edit }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1
  # DELETE /news/1.json
  def destroy
    @news.destroy
    respond_to do |format|
      format.html { redirect_to news_index_url, notice: 'News was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news
      @news = News.friendly.find(params[:id])
    end
  
  def set_news_list
    @news = (current_user.staff? ? News.all.includes(:user) : News.published.includes(:user).where(staffonly: false))

    if (params[:category_id] != nil && params[:category_id] != "-1")
        @news = @news
          .where(category: params[:category_id].to_i)
    end

    @news = @news.paginate(:page => params[:page])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_params
      params.require(:news).permit(:title, :content, :content_html, :summary_html, :category, :vidurl, :remote_thumburl_url, :publish_at, :approved, :staffonly)
    end
end
