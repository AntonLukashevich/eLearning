require "test_helper"

class LectureBlocksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get lecture_blocks_index_url
    assert_response :success
  end
end
