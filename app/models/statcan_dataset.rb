class StatcanDataset < ApplicationRecord
  validates :statcan_url, presence: true, uniqueness: true, format: { with: URI::DEFAULT_PARSER.make_regexp }
  validates :name, presence: true, uniqueness: true, format: { with: /\A[a-z0-9-]+\z/, message: "must be lowercase with hyphens only" }
  validates :sync_schedule, presence: true
  validate :valid_cron_expression

  private

  def valid_cron_expression
    return unless sync_schedule.present?

    parsed_cron = Fugit::Cron.parse(sync_schedule)
    if parsed_cron.nil?
      errors.add(:sync_schedule, "must be a valid cron expression")
    end
  end
end
