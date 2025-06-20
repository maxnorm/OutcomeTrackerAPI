
json.(@promise,
  :id,
  :text,
  :description,
  :commitment_history_rationale,
  :what_it_means_for_canadians,
  :concise_title,
  :progress_score,
  :progress_summary,
  :source_type,
  :date_issued,
)

# TODO: cache this on promise so we don't have to query the database every time
json.last_evidence_at @promise.evidences.where.not(impact: "neutral").order(updated_at: :desc).first&.updated_at&.strftime("%Y-%m-%d")


json.evidences do
  json.partial! "evidences/evidence", collection: @promise.evidences.where.not(impact: "neutral"), as: :evidence
end
