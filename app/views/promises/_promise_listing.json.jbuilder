# Need: status, last_update, title, description, build_canada_alignment, impact,
#


json.(promise,
  :id,
  :concise_title,
  :description,
  :text,
  :last_evidence_date
)

json.source_url promise.source_document_url

json.(promise,
  :bc_promise_direction,
  :bc_promise_rank,
  :bc_promise_rank_rationale
)

json.(promise,
  :progress_score,
  :progress_summary,
)
