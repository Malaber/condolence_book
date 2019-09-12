require 'test_helper'

class PrivacyControllerTest < ActionDispatch::IntegrationTest
  test "should get privacy" do
    get privacy_privacy_url
    assert_response :success
  end

end
