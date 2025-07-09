class StatcanSyncJob < ApplicationJob
  queue_as :default

  def perform(statcan_dataset)
    data = StatcanFetcher.fetch(statcan_dataset.statcan_url)

    statcan_dataset.update!(
      current_data: data,
      last_synced_at: Time.current
    )
  end
end
