require 'test_helper'

class AccessPermissionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get access_permissions_new_url
    assert_response :success
  end

  test "should get edit" do
    get access_permissions_edit_url
    assert_response :success
  end

  test "should get index" do
    get access_permissions_index_url
    assert_response :success
  end

  test "should get show" do
    get access_permissions_show_url
    assert_response :success
  end

end
