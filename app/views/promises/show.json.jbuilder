
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
json.source_url @promise.source_document_url


json.evidences do
  json.partial! "evidences/evidence", collection: @promise.evidences.impactful, as: :evidence
end
