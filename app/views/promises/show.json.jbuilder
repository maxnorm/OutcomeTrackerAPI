
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
  :last_evidence_date
)

json.evidences do
  json.partial! "evidences/evidence", collection: @promise.evidences.where.not(impact: "neutral"), as: :evidence
end
