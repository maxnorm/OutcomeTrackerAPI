require "test_helper"

class MinisterTest < ActiveSupport::TestCase
  test "that each department has a minister" do
    # Ensure that each department has
    assert_equal 0, Department.joins(:ministers).where(ministers: { id: nil }).count
  end
end
