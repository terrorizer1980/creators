class ArticleCollectionsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_article_collection, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource  

  # GET /article_collections
  # GET /article_collections.json
  def index
    @article_collections = ArticleCollection.all
  end

  # GET /article_collections/1
  # GET /article_collections/1.json
  def show
  end

  # GET /article_collections/new
  def new
    @article_collection = ArticleCollection.new
  end

  # GET /article_collections/1/edit
  def edit
  end

  # POST /article_collections
  # POST /article_collections.json
  def create
    @article_collection = ArticleCollection.new(article_collection_params)

    respond_to do |format|
      if @article_collection.save
        format.html { redirect_to @article_collection, notice: 'Article collection was successfully created.' }
        format.json { render :show, status: :created, location: @article_collection }
      else
        format.html { render :new }
        format.json { render json: @article_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /article_collections/1
  # PATCH/PUT /article_collections/1.json
  def update
    respond_to do |format|
      if @article_collection.update(article_collection_params)
        format.html { redirect_to @article_collection, notice: 'Article collection was successfully updated.' }
        format.json { render :show, status: :ok, location: @article_collection }
      else
        format.html { render :edit }
        format.json { render json: @article_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /article_collections/1
  # DELETE /article_collections/1.json
  def destroy
    @article_collection.destroy
    respond_to do |format|
      format.html { redirect_to article_collections_url, notice: 'Article collection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article_collection
      @article_collection = ArticleCollection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_collection_params
      params.require(:article_collection).permit(:name, :description, :picture, :slug, :category)
    end
end
