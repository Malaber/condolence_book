# frozen_string_literal: true

require 'test_helper'

class FillerControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get filler_index_url
    assert_response :success
  end
end
