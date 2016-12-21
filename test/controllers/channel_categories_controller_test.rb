require 'test_helper'

class ChannelCategoriesControllerTest < ActionController::TestCase
  setup do
    @channel_category = channel_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:channel_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create channel_category" do
    assert_difference('ChannelCategory.count') do
      post :create, channel_category: { channel_id: @channel_category.channel_id, description: @channel_category.description }
    end

    assert_redirected_to channel_category_path(assigns(:channel_category))
  end

  test "should show channel_category" do
    get :show, id: @channel_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @channel_category
    assert_response :success
  end

  test "should update channel_category" do
    patch :update, id: @channel_category, channel_category: { channel_id: @channel_category.channel_id, description: @channel_category.description }
    assert_redirected_to channel_category_path(assigns(:channel_category))
  end

  test "should destroy channel_category" do
    assert_difference('ChannelCategory.count', -1) do
      delete :destroy, id: @channel_category
    end

    assert_redirected_to channel_categories_path
  end
end
