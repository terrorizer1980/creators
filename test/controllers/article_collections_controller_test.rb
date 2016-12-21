require 'test_helper'

class ArticleCollectionsControllerTest < ActionController::TestCase
  setup do
    @article_collection = article_collections(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:article_collections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create article_collection" do
    assert_difference('ArticleCollection.count') do
      post :create, article_collection: { category: @article_collection.category, description: @article_collection.description, name: @article_collection.name, picture: @article_collection.picture, slug: @article_collection.slug }
    end

    assert_redirected_to article_collection_path(assigns(:article_collection))
  end

  test "should show article_collection" do
    get :show, id: @article_collection
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @article_collection
    assert_response :success
  end

  test "should update article_collection" do
    patch :update, id: @article_collection, article_collection: { category: @article_collection.category, description: @article_collection.description, name: @article_collection.name, picture: @article_collection.picture, slug: @article_collection.slug }
    assert_redirected_to article_collection_path(assigns(:article_collection))
  end

  test "should destroy article_collection" do
    assert_difference('ArticleCollection.count', -1) do
      delete :destroy, id: @article_collection
    end

    assert_redirected_to article_collections_path
  end
end
