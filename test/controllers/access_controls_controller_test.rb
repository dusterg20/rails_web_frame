require 'test_helper'

class AccessControlsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get access_controls_show_url
    assert_response :success
  end

  test "should get new" do
    get access_controls_new_url
    assert_response :success
  end

  test "should get index" do
    get access_controls_index_url
    assert_response :success
  end

  test "should get edit" do
    get access_controls_edit_url
    assert_response :success
  end

end
