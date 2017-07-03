require 'test_helper'

class IpAddressControllerTest < ActionDispatch::IntegrationTest
  test "should get menu" do
    get ip_address_menu_url
    assert_response :success
  end

  test "should get dispense" do
    get ip_address_dispense_url
    assert_response :success
  end

  test "should get delete" do
    get ip_address_delete_url
    assert_response :success
  end

end
