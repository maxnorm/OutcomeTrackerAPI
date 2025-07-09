require "test_helper"

class StatcanSyncJobTest < ActiveJob::TestCase
  test "should update dataset with fetched data" do
    dataset = statcan_datasets(:unsynced)
    parsed_data = [ { "population" => 1000000, "year" => 2023 } ]

    StatcanFetcher.stub :fetch, parsed_data do
      StatcanSyncJob.perform_now(dataset)
    end

    dataset.reload
    assert_equal parsed_data, dataset.current_data
    assert_not_nil dataset.last_synced_at
  end

  test "should not update dataset when fetch times out" do
    dataset = statcan_datasets(:unsynced)

    StatcanFetcher.stub :fetch, ->(url) { raise HTTP::TimeoutError.new("Request timed out") } do
      assert_raises HTTP::TimeoutError do
        StatcanSyncJob.perform_now(dataset)
      end
    end

    dataset.reload
    assert_nil dataset.current_data
  end
end
