require 'test_helper'

class ImpressumControllerTest < ActionDispatch::IntegrationTest
  test "should get impressum" do
    get impressum_impressum_url
    assert_response :success
  end

end
