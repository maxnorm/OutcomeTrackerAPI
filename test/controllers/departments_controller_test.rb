require "test_helper"

class DepartmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @department = Department.first
  end

  test "should get index" do
    get departments_url, as: :json
    assert_response :success
  end

  test "should show department" do
    get department_url(@department), as: :json
    assert_response :success
  end
end
