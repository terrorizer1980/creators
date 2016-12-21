require 'test_helper'

class PpipnsControllerTest < ActionController::TestCase
  setup do
    @ppipn = ppipns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ppipns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ppipn" do
    assert_difference('Ppipn.count') do
      post :create, ppipn: { params: @ppipn.params }
    end

    assert_redirected_to ppipn_path(assigns(:ppipn))
  end

  test "should show ppipn" do
    get :show, id: @ppipn
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ppipn
    assert_response :success
  end

  test "should update ppipn" do
    patch :update, id: @ppipn, ppipn: { params: @ppipn.params }
    assert_redirected_to ppipn_path(assigns(:ppipn))
  end

  test "should destroy ppipn" do
    assert_difference('Ppipn.count', -1) do
      delete :destroy, id: @ppipn
    end

    assert_redirected_to ppipns_path
  end
end
