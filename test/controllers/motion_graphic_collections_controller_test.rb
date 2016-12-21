require 'test_helper'

class MotionGraphicCollectionsControllerTest < ActionController::TestCase
  setup do
    @motion_graphic_collection = motion_graphic_collections(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:motion_graphic_collections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create motion_graphic_collection" do
    assert_difference('MotionGraphicCollection.count') do
      post :create, motion_graphic_collection: {  }
    end

    assert_redirected_to motion_graphic_collection_path(assigns(:motion_graphic_collection))
  end

  test "should show motion_graphic_collection" do
    get :show, id: @motion_graphic_collection
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @motion_graphic_collection
    assert_response :success
  end

  test "should update motion_graphic_collection" do
    patch :update, id: @motion_graphic_collection, motion_graphic_collection: {  }
    assert_redirected_to motion_graphic_collection_path(assigns(:motion_graphic_collection))
  end

  test "should destroy motion_graphic_collection" do
    assert_difference('MotionGraphicCollection.count', -1) do
      delete :destroy, id: @motion_graphic_collection
    end

    assert_redirected_to motion_graphic_collections_path
  end
end
