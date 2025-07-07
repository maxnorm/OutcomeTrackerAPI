require "test_helper"

class StatcanSyncJobTest < ActiveJob::TestCase
  def setup
    @dataset = StatcanDataset.create!(
      name: "test-dataset",
      statcan_url: "https://statcan.gc.ca/test.csv",
      sync_schedule: "0 0 * * *"
    )
  end

  test "should update dataset with fetched data" do
    parsed_data = [ { "year" => 2020, "population" => 38000000 } ]

    StatcanFetcher.stub :fetch, parsed_data do
      StatcanSyncJob.perform_now(@dataset.id)
    end

    @dataset.reload
    assert_equal parsed_data, @dataset.current_data
    assert_not_nil @dataset.last_synced_at
  end

  test "should not update dataset when fetch times out" do
    StatcanFetcher.stub :fetch, ->(url) { raise HTTP::TimeoutError.new("Request timed out") } do
      assert_raises HTTP::TimeoutError do
        StatcanSyncJob.perform_now(@dataset.id)
      end
    end

    @dataset.reload
    assert_nil @dataset.current_data
  end
end
