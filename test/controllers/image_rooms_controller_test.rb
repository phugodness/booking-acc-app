require 'test_helper'

class ImageRoomsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get image_rooms_new_url
    assert_response :success
  end
end
