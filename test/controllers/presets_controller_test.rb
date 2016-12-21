require 'test_helper'

class PresetsControllerTest < ActionController::TestCase
  setup do
    @preset = presets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:presets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create preset" do
    assert_difference('Preset.count') do
      post :create, preset: { background_template_id: @preset.background_template_id, channel_id: @preset.channel_id, customizeintropervideo: @preset.customizeintropervideo, endcard_template_id: @preset.endcard_template_id, intro_template_id: @preset.intro_template_id, l3_template_id: @preset.l3_template_id, name: @preset.name }
    end

    assert_redirected_to preset_path(assigns(:preset))
  end

  test "should show preset" do
    get :show, id: @preset
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @preset
    assert_response :success
  end

  test "should update preset" do
    patch :update, id: @preset, preset: { background_template_id: @preset.background_template_id, channel_id: @preset.channel_id, customizeintropervideo: @preset.customizeintropervideo, endcard_template_id: @preset.endcard_template_id, intro_template_id: @preset.intro_template_id, l3_template_id: @preset.l3_template_id, name: @preset.name }
    assert_redirected_to preset_path(assigns(:preset))
  end

  test "should destroy preset" do
    assert_difference('Preset.count', -1) do
      delete :destroy, id: @preset
    end

    assert_redirected_to presets_path
  end
end
