require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase
  setup do
    @subscription = subscriptions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subscriptions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subscription" do
    assert_difference('Subscription.count') do
      post :create, subscription: { billingperiod: @subscription.billingperiod, paymethod: @subscription.paymethod, paypal_customer_token: @subscription.paypal_customer_token, paypal_recurring_profile_token: @subscription.paypal_recurring_profile_token, paypal_subscription_amount: @subscription.paypal_subscription_amount, paypal_subscription_description: @subscription.paypal_subscription_description, user_id: @subscription.user_id }
    end

    assert_redirected_to subscription_path(assigns(:subscription))
  end

  test "should show subscription" do
    get :show, id: @subscription
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @subscription
    assert_response :success
  end

  test "should update subscription" do
    patch :update, id: @subscription, subscription: { billingperiod: @subscription.billingperiod, paymethod: @subscription.paymethod, paypal_customer_token: @subscription.paypal_customer_token, paypal_recurring_profile_token: @subscription.paypal_recurring_profile_token, paypal_subscription_amount: @subscription.paypal_subscription_amount, paypal_subscription_description: @subscription.paypal_subscription_description, user_id: @subscription.user_id }
    assert_redirected_to subscription_path(assigns(:subscription))
  end

  test "should destroy subscription" do
    assert_difference('Subscription.count', -1) do
      delete :destroy, id: @subscription
    end

    assert_redirected_to subscriptions_path
  end
end
