require 'test_helper'

class SubnetControllerTest < ActionDispatch::IntegrationTest
  test "should get menu" do
    get subnet_menu_url
    assert_response :success
  end

  test "should get register" do
    get subnet_register_url
    assert_response :success
  end

  test "should get delete" do
    get subnet_delete_url
    assert_response :success
  end

  test "should get list" do
    get subnet_list_url
    assert_response :success
  end

  test "should get ip_list" do
    get subnet_ip_list_url
    assert_response :success
  end

end
