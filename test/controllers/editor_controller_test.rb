require 'test_helper'

class EditorControllerTest < ActionDispatch::IntegrationTest
  test "should editor editor" do
    editor editor_get_url
    assert_response :success
  end

end
