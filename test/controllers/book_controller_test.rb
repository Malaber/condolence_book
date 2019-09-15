require 'test_helper'

class BookControllerTest < ActionDispatch::IntegrationTest
  test "should get book" do
    get book_book_url
    assert_response :success
  end

end
