class StatcanSyncJob < ApplicationJob
  queue_as :default

  def perform(statcan_dataset_id)
    dataset = StatcanDataset.find(statcan_dataset_id)
    data = StatcanFetcher.fetch(dataset.statcan_url)

    dataset.update!(
      current_data: data,
      last_synced_at: Time.current
    )
  end
end
