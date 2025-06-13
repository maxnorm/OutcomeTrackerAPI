class Avo::Resources::Evidence < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :raw_gazette_notice_id, as: :text
    field :rias_summary, as: :textarea
    field :description_or_details, as: :textarea
    field :evidence_date, as: :date_time
    field :evidence_id, as: :text
    field :evidence_source_type, as: :text
    field :hybrid_linking_avg_confidence, as: :number
    field :hybrid_linking_method, as: :text
    field :hybrid_linking_timestamp, as: :date_time
    field :ingested_at, as: :date_time
    field :parliament_session_id, as: :text
    field :promise_linking_processed_at, as: :date_time
    field :promise_linking_status, as: :text
    field :promise_links_found2, as: :number
    field :source_document_raw_id, as: :text
    field :source_url, as: :text
    field :title_or_summary, as: :textarea
    field :key_concepts, as: :textarea
    field :linked_departments, as: :textarea
    field :promise_ids, as: :textarea
    field :llm_analysis_raw, as: :code
  end
end
