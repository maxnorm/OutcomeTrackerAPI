require "test_helper"

class StatcanDatasetsControllerTest < ActionDispatch::IntegrationTest
  test "should show dataset" do
    dataset = StatcanDataset.create!(
       statcan_url: "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1410028701",
       name: "demographic-incomes",
       sync_schedule: "0 6 * * *",
       current_data: [ { "year" => 2020, "population" => 38000000 } ],
       last_synced_at: Time.parse("2025-01-01 23:00:00")  # Yesterday 11pm
    )

    get statcan_dataset_url(dataset)

    assert_response :success
    assert_equal "application/json; charset=utf-8", response.content_type

    json_response = JSON.parse(response.body)
    assert_equal dataset.id, json_response["id"]
    assert_equal dataset.name, json_response["name"]
  end

  test "should return 404 for non-existent dataset" do
    get statcan_dataset_url(id: 99999)

    assert_response :not_found
  end
end
