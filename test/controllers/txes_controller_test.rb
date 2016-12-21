require 'test_helper'

class TxesControllerTest < ActionController::TestCase
  setup do
    @tx = txes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:txes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tx" do
    assert_difference('Tx.count') do
      post :create, tx: { amount_cents: @tx.amount_cents, balance_cents: @tx.balance_cents, currency: @tx.currency, direction: @tx.direction, notes: @tx.notes, txtype: @tx.txtype, user_id: @tx.user_id }
    end

    assert_redirected_to tx_path(assigns(:tx))
  end

  test "should show tx" do
    get :show, id: @tx
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tx
    assert_response :success
  end

  test "should update tx" do
    patch :update, id: @tx, tx: { amount_cents: @tx.amount_cents, balance_cents: @tx.balance_cents, currency: @tx.currency, direction: @tx.direction, notes: @tx.notes, txtype: @tx.txtype, user_id: @tx.user_id }
    assert_redirected_to tx_path(assigns(:tx))
  end

  test "should destroy tx" do
    assert_difference('Tx.count', -1) do
      delete :destroy, id: @tx
    end

    assert_redirected_to txes_path
  end
end
