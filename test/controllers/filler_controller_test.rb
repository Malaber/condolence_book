require 'test_helper'

class FillerControllerTest < ActionDispatch::IntegrationTest
  test "should editor index" do
    editor filler_index_url
    assert_response :success
  end

end
