require "test_helper"

class MinistersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @minister = Minister.first
  end

  test "should get index" do
    get ministers_url, as: :json
    assert_response :success
  end

  test "should show minister" do
    get minister_url(@minister), as: :json
    assert_response :success
  end
end
