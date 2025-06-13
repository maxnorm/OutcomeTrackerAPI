class CreateEvidences < ActiveRecord::Migration[8.0]
  def change
    create_table :evidences do |t|
      t.string :raw_gazette_notice_id
      t.text :rias_summary
      t.text :description_or_details
      t.datetime :evidence_date
      t.string :evidence_id
      t.string :evidence_source_type
      t.float :hybrid_linking_avg_confidence
      t.string :hybrid_linking_method
      t.datetime :hybrid_linking_timestamp
      t.datetime :ingested_at
      t.string :parliament_session_id
      t.datetime :promise_linking_processed_at
      t.string :promise_linking_status
      t.integer :promise_links_found2
      t.string :source_document_raw_id
      t.string :source_url
      t.text :title_or_summary
      t.text :key_concepts, array: true, default: []
      t.text :linked_departments, array: true, default: []
      t.text :promise_ids, array: true, default: []
      t.jsonb :llm_analysis_raw, default: {}

      t.timestamps
    end
  end
end
