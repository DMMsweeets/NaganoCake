require 'test_helper'

class Public::OrderControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_order_index_url
    assert_response :success
  end

  test "should get show" do
    get public_order_show_url
    assert_response :success
  end

  test "should get new" do
    get public_order_new_url
    assert_response :success
  end

end
