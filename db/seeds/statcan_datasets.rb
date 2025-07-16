require 'json'

puts "Seeding StatcanDatasets..."

last_synced_at = Time.parse("2025-07-16 09:00:00")

# Helper method to load JSON data
def load_json(path)
  JSON.parse(File.read(path))
end

statcan_datasets = [
  {
    name: "balance-sheets",
    statcan_url: "https://www150.statcan.gc.ca/t1/tbl1/en/dtl!downloadDbLoadingData-nonTraduit.action?pid=1010001501&latestN=0&startDate=19901001&endDate=&csvLocale=en&selectedMembers=%5B%5B1%5D%2C%5B2%5D%2C%5B%5D%5D&checkedLevels=2D1%2C2D2%2C2D3",
    sync_schedule: "23 6 * * *", # Daily at 6:23 AM
    last_synced_at: last_synced_at,
    current_data: load_json("db/seeds/statcan_data/balance_sheets.json")
  },
  {
    name: "demographic-incomes-non-permanent-residents",
    statcan_url: "https://www150.statcan.gc.ca/t1/tbl1/en/dtl!downloadDbLoadingData-nonTraduit.action?pid=1110009101&latestN=2&startDate=&endDate=&csvLocale=en&selectedMembers=%5B%5B1%5D%2C%5B%5D%2C%5B%5D%2C%5B%5D%2C%5B5%5D%5D&checkedLevels=1D1%2C1D2%2C1D3%2C2D1%2C3D1",
    sync_schedule: "23 8 * * *", # Daily at 8:23 AM
    last_synced_at: last_synced_at,
    current_data: load_json("db/seeds/statcan_data/demographic_incomes_non_permanent_residents.json")
  },
  {
    name: "gdp",
    statcan_url: "https://www150.statcan.gc.ca/t1/tbl1/en/dtl!downloadDbLoadingData-nonTraduit.action?pid=3610010401&latestN=0&startDate=19610101&endDate=&csvLocale=en&selectedMembers=%5B%5B1%5D%2C%5B1%5D%2C%5B1%5D%2C%5B%5D%5D&checkedLevels=3D1%2C3D2%2C3D3%2C3D4",
    sync_schedule: "23 6 * * *", # Daily at 6:23 AM
    last_synced_at: last_synced_at,
    current_data: load_json("db/seeds/statcan_data/gdp.json")
  },
  {
    name: "housing-starts",
    statcan_url: "https://www150.statcan.gc.ca/t1/tbl1/en/dtl!downloadDbLoadingData.action?pid=3410015101&latestN=0&startDate=19880101&endDate=&csvLocale=en&selectedMembers=%5B%5B%5D%2C%5B1%5D%2C%5B%5D%5D&checkedLevels=0D1%2C2D1%2C2D2",
    sync_schedule: "23 6 * * *", # Daily at 6:23 AM
    last_synced_at: last_synced_at,
    current_data: load_json("db/seeds/statcan_data/housing_starts.json")
  },
  {
    name: "labour-productivity",
    statcan_url: "https://www150.statcan.gc.ca/t1/tbl1/en/dtl!downloadDbLoadingData-nonTraduit.action?pid=3610020701&latestN=0&startDate=19801001&endDate=&csvLocale=en&selectedMembers=%5B%5B1%5D%2C%5B5%5D%2C%5B1%2C2%2C3%2C4%2C5%2C6%2C7%2C8%2C9%2C10%2C11%2C13%2C14%2C15%2C16%2C17%2C18%2C19%2C20%2C21%5D%5D&checkedLevels=",
    sync_schedule: "23 9 * * *", # Daily at 9:23 AM
    last_synced_at: last_synced_at,
    current_data: load_json("db/seeds/statcan_data/labour_productivity.json")
  },
  {
    name: "non-permanent-residents",
    statcan_url: "https://www150.statcan.gc.ca/t1/tbl1/en/dtl!downloadDbLoadingData.action?pid=1710012101&latestN=0&startDate=20210101&endDate=&csvLocale=en&selectedMembers=%5B%5B%5D%2C%5B%5D%5D&checkedLevels=0D1%2C1D1%2C1D2%2C1D3",
    sync_schedule: "23 7 * * *", # Daily at 7:23 AM
    last_synced_at: last_synced_at,
    current_data: load_json("db/seeds/statcan_data/non_permanent_residents.json")
  },
  {
    name: "population",
    statcan_url: "https://www150.statcan.gc.ca/t1/tbl1/en/dtl!downloadDbLoadingData-nonTraduit.action?pid=1710000901&latestN=0&startDate=19000101&endDate=&csvLocale=en&selectedMembers=%5B%5B1%2C2%2C3%2C4%2C5%2C6%2C7%2C8%2C9%2C10%2C11%2C12%2C14%2C15%5D%5D&checkedLevels=",
    sync_schedule: "23 6 * * *", # Daily at 6:23 AM
    last_synced_at: last_synced_at,
    current_data: load_json("db/seeds/statcan_data/population.json")
  },
  {
    name: "primary-energy-production",
    statcan_url: "https://www150.statcan.gc.ca/t1/tbl1/en/dtl!downloadDbLoadingData-nonTraduit.action?pid=2510007901&latestN=5&startDate=&endDate=&csvLocale=en&selectedMembers=%5B%5B%5D%2C%5B%5D%2C%5B%5D%5D&checkedLevels=0D1%2C1D1%2C1D2%2C1D3%2C2D1",
    sync_schedule: "23 10 * * *", # Daily at 10:23 AM
    last_synced_at: last_synced_at,
    current_data: load_json("db/seeds/statcan_data/primary_energy_production.json")
  }
]

statcan_datasets.each do |dataset_attrs|
  dataset = StatcanDataset.find_or_create_by(name: dataset_attrs[:name]) do |d|
    d.statcan_url = dataset_attrs[:statcan_url]
    d.sync_schedule = dataset_attrs[:sync_schedule]
    d.last_synced_at = dataset_attrs[:last_synced_at]
    d.current_data = dataset_attrs[:current_data]
  end

  if dataset.persisted?
    if dataset.previously_new_record?
      puts "✓ #{dataset.name} - created"
    else
      puts "✓ #{dataset.name} - already exists"
    end
  else
    puts "✗ #{dataset.name} - failed to create: #{dataset.errors.full_messages.join(', ')}"
  end
end
