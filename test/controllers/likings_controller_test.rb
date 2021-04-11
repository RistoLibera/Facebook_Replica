require "test_helper"

class LikingsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get likings_new_url
    assert_response :success
  end

  test "should get create" do
    get likings_create_url
    assert_response :success
  end

  test "should get update" do
    get likings_update_url
    assert_response :success
  end
end
