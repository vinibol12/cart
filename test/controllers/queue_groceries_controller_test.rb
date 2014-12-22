require 'test_helper'

class QueueGroceriesControllerTest < ActionController::TestCase
  setup do
    @queue_grocery = queue_groceries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:queue_groceries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create queue_grocery" do
    assert_difference('QueueGrocery.count') do
      post :create, queue_grocery: { basket_id: @queue_grocery.cart_id, product_id: @queue_grocery.product_id }
    end

    assert_redirected_to queue_grocery_path(assigns(:queue_grocery))
  end

  test "should show queue_grocery" do
    get :show, id: @queue_grocery
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @queue_grocery
    assert_response :success
  end

  test "should update queue_grocery" do
    patch :update, id: @queue_grocery, queue_grocery: { basket_id: @queue_grocery.cart_id, product_id: @queue_grocery.product_id }
    assert_redirected_to queue_grocery_path(assigns(:queue_grocery))
  end

  test "should destroy queue_grocery" do
    assert_difference('QueueGrocery.count', -1) do
      delete :destroy, id: @queue_grocery
    end

    assert_redirected_to queue_groceries_path
  end
end
