# test/models/statcan_dataset_test.rb
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
end
