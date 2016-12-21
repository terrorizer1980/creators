require 'test_helper'

class MotionGraphicsControllerTest < ActionController::TestCase
  setup do
    @motion_graphic = motion_graphics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:motion_graphics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create motion_graphic" do
    assert_difference('MotionGraphic.count') do
      post :create, motion_graphic: { category: @motion_graphic.category, description: @motion_graphic.description, name: @motion_graphic.name, user_id: @motion_graphic.user_id, vidurl: @motion_graphic.vidurl }
    end

    assert_redirected_to motion_graphic_path(assigns(:motion_graphic))
  end

  test "should show motion_graphic" do
    get :show, id: @motion_graphic
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @motion_graphic
    assert_response :success
  end

  test "should update motion_graphic" do
    patch :update, id: @motion_graphic, motion_graphic: { category: @motion_graphic.category, description: @motion_graphic.description, name: @motion_graphic.name, user_id: @motion_graphic.user_id, vidurl: @motion_graphic.vidurl }
    assert_redirected_to motion_graphic_path(assigns(:motion_graphic))
  end

  test "should destroy motion_graphic" do
    assert_difference('MotionGraphic.count', -1) do
      delete :destroy, id: @motion_graphic
    end

    assert_redirected_to motion_graphics_path
  end
end
