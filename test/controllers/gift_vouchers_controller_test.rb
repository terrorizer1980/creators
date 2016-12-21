require 'test_helper'

class GiftVouchersControllerTest < ActionController::TestCase
  setup do
    @gift_voucher = gift_vouchers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gift_vouchers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gift_voucher" do
    assert_difference('GiftVoucher.count') do
      post :create, gift_voucher: { from_user_id: @gift_voucher.from_user_id, message: @gift_voucher.message, name: @gift_voucher.name, user_id: @gift_voucher.user_id }
    end

    assert_redirected_to gift_voucher_path(assigns(:gift_voucher))
  end

  test "should show gift_voucher" do
    get :show, id: @gift_voucher
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gift_voucher
    assert_response :success
  end

  test "should update gift_voucher" do
    patch :update, id: @gift_voucher, gift_voucher: { from_user_id: @gift_voucher.from_user_id, message: @gift_voucher.message, name: @gift_voucher.name, user_id: @gift_voucher.user_id }
    assert_redirected_to gift_voucher_path(assigns(:gift_voucher))
  end

  test "should destroy gift_voucher" do
    assert_difference('GiftVoucher.count', -1) do
      delete :destroy, id: @gift_voucher
    end

    assert_redirected_to gift_vouchers_path
  end
end
