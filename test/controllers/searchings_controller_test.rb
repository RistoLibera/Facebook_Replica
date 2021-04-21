require "test_helper"

class SearchingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get searchings_index_url
    assert_response :success
  end

  test "should get destroy" do
    get searchings_destroy_url
    assert_response :success
  end
end
