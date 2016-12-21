require 'test_helper'

class UserGalleriesControllerTest < ActionController::TestCase
  setup do
    @user_gallery = user_galleries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_galleries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_gallery" do
    assert_difference('UserGallery.count') do
      post :create, user_gallery: {  }
    end

    assert_redirected_to user_gallery_path(assigns(:user_gallery))
  end

  test "should show user_gallery" do
    get :show, id: @user_gallery
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_gallery
    assert_response :success
  end

  test "should update user_gallery" do
    patch :update, id: @user_gallery, user_gallery: {  }
    assert_redirected_to user_gallery_path(assigns(:user_gallery))
  end

  test "should destroy user_gallery" do
    assert_difference('UserGallery.count', -1) do
      delete :destroy, id: @user_gallery
    end

    assert_redirected_to user_galleries_path
  end
end
