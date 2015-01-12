require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:one)
  end

  test "should get index"  do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end
  test "requires item in the basket" do
    get :new
    assert_redirected_to store_path
    assert_equal flash[:notice], 'Your basket is empty'
  end

  test "should get new" do
    item = QueueGrocery.new #assigns a new QueueGrocery empty object to the local variable item
    item.build_basket       #creates a relationship between the item and a basket
    item.product = products(:ruby) #pics the fixture :ruby to use as data for the test
    item.save #saves the item in the db
    session[:basket_id] = item.basket.id # index the session to the basket id and relates that to the object
    get :new #calls the action new and
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, order: { address: @order.address, email: @order.email, name: @order.name, pay_type: @order.pay_type }
    end

    assert_redirected_to store_url
  end

  test "should show order" do
    get :show, id: @order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order
    assert_response :success
  end

  test "should update order" do
    patch :update, id: @order, order: { address: @order.address, email: @order.email, name: @order.name, pay_type: @order.pay_type }
    assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to orders_path
  end
end
