class AddErrorToFeeds < ActiveRecord::Migration[8.0]
  def change
    remove_column :feeds, :last_scraped, :timestamp
    add_column :feeds, :last_scraped_at, :timestamp
    add_column :feeds, :error_message, :string
    add_column :feeds, :last_scrape_failed_at, :timestamp
  end
end
