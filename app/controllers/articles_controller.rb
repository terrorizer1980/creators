class ArticlesController < PublishablesController
  before_filter :authenticate_user!
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  
  # GET /articles
  # GET /articles.json
  def index
    @article_collections = ArticleCollection.all
    set_article_list
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    
    @article = Article.new()
    
    set_publishable_params(params[:article], @article)
    
    @article.assign_attributes(article_params)
    @article.user_id = current_user.id
    
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    
    set_publishable_params(params[:article], @article)
    
    @article.assign_attributes(article_params)
    
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.friendly.find(params[:id])
    end
  
  def set_article_list
    @articles = (current_user.staff? ? Article.all.includes(:user) : Article.published.includes(:user))

    if (params[:category_id] != nil && params[:category_id] != "-1")
        @articles = @articles
          .where(category: params[:category_id].to_i)
    end

    # TODO: Create the search for articles included in collection
    if (params[:collection_id] != nil && params[:collection_id] != "-1")
      @articles = @articles
        .where('id IN (' + 
          ArticleCollectionsArticle
            .select(:article_id)
            .includes(:articles)
            .where(:article_collection_id => params[:collection_id])
            .to_sql + 
        ')')
    end

    @articles = @articles.paginate(:page => params[:page])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def article_params
    params.require(:article).permit(:category, :title, :content, :content_html, :summary_html, :vidurl, :remote_thumburl_url, :publish_at, :approved, :article_collection_ids => [])
  end
end
