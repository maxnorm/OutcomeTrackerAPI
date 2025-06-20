# Need: status, last_update, title, description, build_canada_alignment, impact,
#


json.(promise,
  :id,
  :concise_title,
  :description,
  :text
)

# TODO: cache this on promise so we don't have to query the database every time
json.last_evidence_at promise.evidences.order(updated_at: :desc).first&.updated_at&.strftime("%Y-%m-%d")

json.(promise,
  :bc_promise_direction,
  :bc_promise_rank,
  :bc_promise_rank_rationale
)

json.(promise,
  :progress_score,
  :progress_summary,

  )
