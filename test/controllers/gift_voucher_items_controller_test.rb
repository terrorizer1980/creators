require 'test_helper'

class GiftVoucherItemsControllerTest < ActionController::TestCase
  setup do
    @gift_voucher_item = gift_voucher_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gift_voucher_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gift_voucher_item" do
    assert_difference('GiftVoucherItem.count') do
      post :create, gift_voucher_item: { description: @gift_voucher_item.description, discount: @gift_voucher_item.discount, gift_voucher_id: @gift_voucher_item.gift_voucher_id, name: @gift_voucher_item.name, product_id: @gift_voucher_item.product_id, quantity: @gift_voucher_item.quantity, status: @gift_voucher_item.status }
    end

    assert_redirected_to gift_voucher_item_path(assigns(:gift_voucher_item))
  end

  test "should show gift_voucher_item" do
    get :show, id: @gift_voucher_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gift_voucher_item
    assert_response :success
  end

  test "should update gift_voucher_item" do
    patch :update, id: @gift_voucher_item, gift_voucher_item: { description: @gift_voucher_item.description, discount: @gift_voucher_item.discount, gift_voucher_id: @gift_voucher_item.gift_voucher_id, name: @gift_voucher_item.name, product_id: @gift_voucher_item.product_id, quantity: @gift_voucher_item.quantity, status: @gift_voucher_item.status }
    assert_redirected_to gift_voucher_item_path(assigns(:gift_voucher_item))
  end

  test "should destroy gift_voucher_item" do
    assert_difference('GiftVoucherItem.count', -1) do
      delete :destroy, id: @gift_voucher_item
    end

    assert_redirected_to gift_voucher_items_path
  end
end
