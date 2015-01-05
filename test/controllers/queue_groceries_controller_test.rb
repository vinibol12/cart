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
  #3) Error:
     # QueueGroceriesControllerTest#test_should_get_new:
  #ActionView::Template::Error: 'nil' is not an ActiveModel-compatible object. It must implement :to_partial_path.
   # app/views/layouts/application.html.erb:24:in `_app_views_layouts_application_html_erb__2110286247247439725_70246977131000'
   # test/controllers/queue_groceries_controller_test.rb:15:in `block in <class:QueueGroceriesControllerTest>'


  test "should create queue_grocery" do
    assert_difference('QueueGrocery.count') do
      post :create, product_id: products(:ruby).id
    end

    assert_redirected_to store_url
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
    patch :update, id: @queue_grocery, queue_grocery: { product_id: @queue_grocery.product_id }
    assert_redirected_to queue_grocery_path(assigns(:queue_grocery))
  end

  test "should destroy queue_grocery" do
    assert_difference('QueueGrocery.count', -1) do
      delete :destroy, id: @queue_grocery
    end

    assert_redirected_to queue_groceries_path
  end
end
