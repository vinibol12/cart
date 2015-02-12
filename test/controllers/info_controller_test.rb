require 'test_helper'

class InfoControllerTest < ActionController::TestCase
  test "should get contact" do
    get :contact
    assert_response :success
  end

  test "should get faq" do
    get :faq
    assert_response :success
  end

  test "should get news" do
    get :news
    assert_response :success
  end

end
