require 'test_helper'

class ControlsControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get controls_home_url
    assert_response :success
  end

end
