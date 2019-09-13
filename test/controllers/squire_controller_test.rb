require 'test_helper'

class SquireControllerTest < ActionDispatch::IntegrationTest
  test "should squire squire" do
    squire squire_get_url
    assert_response :success
  end

end
