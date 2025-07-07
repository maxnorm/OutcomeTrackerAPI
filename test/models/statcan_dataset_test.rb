require "test_helper"

class StatcanDatasetTest < ActiveSupport::TestCase
 test "valid dataset" do
   dataset = StatcanDataset.new(
     statcan_url: "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1410028701",
     name: "demographic-incomes",
     sync_schedule: "0 6 * * *"
   )

   assert dataset.valid?
 end

 test "requires statcan_url" do
   dataset = StatcanDataset.new(
     name: "demographic-incomes",
     sync_schedule: "0 6 * * *"
   )

   assert_not dataset.valid?
   assert_includes dataset.errors[:statcan_url], "can't be blank"
 end

 test "requires name" do
   dataset = StatcanDataset.new(
     statcan_url: "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1410028701",
     sync_schedule: "0 6 * * *"
   )

   assert_not dataset.valid?
   assert_includes dataset.errors[:name], "can't be blank"
 end

 test "requires sync_schedule" do
   dataset = StatcanDataset.new(
     statcan_url: "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1410028701",
     name: "demographic-incomes"
   )

   assert_not dataset.valid?
   assert_includes dataset.errors[:sync_schedule], "can't be blank"
 end

 test "statcan_url must be unique" do
   url = "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1410028701"

   StatcanDataset.create!(
     statcan_url: url,
     name: "first-dataset",
     sync_schedule: "0 6 * * *"
   )

   duplicate = StatcanDataset.new(
     statcan_url: url,
     name: "second-dataset",
     sync_schedule: "0 12 * * *"
   )

   assert_not duplicate.valid?
   assert_includes duplicate.errors[:statcan_url], "has already been taken"
 end

 test "name must be unique" do
   name = "demographic-incomes"

   StatcanDataset.create!(
     statcan_url: "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1410028701",
     name: name,
     sync_schedule: "0 6 * * *"
   )

   duplicate = StatcanDataset.new(
     statcan_url: "https://different-url.statcan.gc.ca/data",
     name: name,
     sync_schedule: "0 12 * * *"
   )

   assert_not duplicate.valid?
   assert_includes duplicate.errors[:name], "has already been taken"
 end

 test "name must be kebab-case" do
   dataset = StatcanDataset.new(
     statcan_url: "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1410028701",
     name: "Invalid Name",
     sync_schedule: "0 6 * * *"
   )

   assert_not dataset.valid?
   assert_includes dataset.errors[:name], "must be lowercase with hyphens only"
 end

 test "sync_schedule accepts valid cron expressions" do
   valid_schedules = [ "0 6 * * *", "30 14 1 * *", "0 * * * 0", "15 9 * * 1-5" ]

   valid_schedules.each do |schedule|
     dataset = StatcanDataset.new(
       statcan_url: "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1410028701",
       name: "test-dataset-#{schedule.hash}",
       sync_schedule: schedule
     )

     assert dataset.valid?, "#{schedule} should be valid"
   end
 end

 test "sync_schedule rejects invalid cron expressions" do
   invalid_schedules = [ "invalid", "60 25 32 13 8", "not a cron" ]

   invalid_schedules.each do |schedule|
     dataset = StatcanDataset.new(
       statcan_url: "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1410028701",
       name: "test-dataset-#{schedule.hash}",
       sync_schedule: schedule
     )

     assert_not dataset.valid?, "#{schedule} should be invalid"
     assert_includes dataset.errors[:sync_schedule], "must be a valid cron expression"
   end
 end

 test "needs_sync returns true when last_synced_at is nil" do
  dataset = StatcanDataset.create!(
    name: "test-dataset",
    statcan_url: "https://statcan.gc.ca/test.csv",
    sync_schedule: "0 0 * * *"
  )

  current_time = Time.parse("2025-01-02 14:00:00")
  assert dataset.needs_sync?(current_time)
 end

 test "needs_sync returns true when last sync was before last scheduled time" do
   dataset = StatcanDataset.create!(
     name: "test-dataset-old",
     statcan_url: "https://statcan.gc.ca/test-old.csv",
     sync_schedule: "0 0 * * *",  # Daily at midnight
     last_synced_at: Time.parse("2025-01-01 23:00:00")  # Yesterday 11pm
   )

   current_time = Time.parse("2025-01-02 14:00:00")  # 2pm next day
   assert dataset.needs_sync?(current_time)
 end

 test "needs_sync returns false when last sync was after last scheduled time" do
   dataset = StatcanDataset.create!(
     name: "test-dataset-fresh",
     statcan_url: "https://statcan.gc.ca/test-fresh.csv",
     sync_schedule: "0 0 * * *",  # Daily at midnight
     last_synced_at: Time.parse("2025-01-02 01:00:00")  # 1am today
   )

   current_time = Time.parse("2025-01-02 14:00:00")  # 2pm same day
   assert_not dataset.needs_sync?(current_time)
 end

 test "filter_stale returns datasets that need syncing" do
  stale_dataset = StatcanDataset.create!(
    name: "stale-one",
    statcan_url: "https://statcan.gc.ca/stale1.csv",
    sync_schedule: "0 0 * * *",  # Daily at midnight
    last_synced_at: Time.parse("2025-01-01 23:00:00")  # Yesterday 11pm
  )

  fresh_dataset = StatcanDataset.create!(
    name: "fresh-one",
    statcan_url: "https://statcan.gc.ca/fresh.csv",
    sync_schedule: "0 0 * * *",  # Daily at midnight
    last_synced_at: Time.parse("2025-01-02 01:00:00")  # 1am today
  )

  current_time = Time.parse("2025-01-02 14:00:00")  # 2pm same day
  all_datasets = [ stale_dataset, fresh_dataset ]
  stale_datasets = StatcanDataset.filter_stale(all_datasets, current_time)

  assert_includes stale_datasets, stale_dataset
  assert_not_includes stale_datasets, fresh_dataset
  assert_equal 1, stale_datasets.length
end

 test "filter_stale works with empty collection" do
   stale_datasets = StatcanDataset.filter_stale([])
   assert_empty stale_datasets
 end
end
