require 'test_helper'

class MotionGraphicCustomizationsControllerTest < ActionController::TestCase
  setup do
    @motion_graphic_customization = motion_graphic_customizations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:motion_graphic_customizations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create motion_graphic_customization" do
    assert_difference('MotionGraphicCustomization.count') do
      post :create, motion_graphic_customization: { custom_field_data: @motion_graphic_customization.custom_field_data, motion_graphic_id: @motion_graphic_customization.motion_graphic_id, user_id: @motion_graphic_customization.user_id }
    end

    assert_redirected_to motion_graphic_customization_path(assigns(:motion_graphic_customization))
  end

  test "should show motion_graphic_customization" do
    get :show, id: @motion_graphic_customization
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @motion_graphic_customization
    assert_response :success
  end

  test "should update motion_graphic_customization" do
    patch :update, id: @motion_graphic_customization, motion_graphic_customization: { custom_field_data: @motion_graphic_customization.custom_field_data, motion_graphic_id: @motion_graphic_customization.motion_graphic_id, user_id: @motion_graphic_customization.user_id }
    assert_redirected_to motion_graphic_customization_path(assigns(:motion_graphic_customization))
  end

  test "should destroy motion_graphic_customization" do
    assert_difference('MotionGraphicCustomization.count', -1) do
      delete :destroy, id: @motion_graphic_customization
    end

    assert_redirected_to motion_graphic_customizations_path
  end
end
