# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_06_13_154602) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "departments", force: :cascade do |t|
    t.bigint "government_id", null: false
    t.string "slug", null: false
    t.string "official_name", null: false
    t.string "display_name", null: false
    t.integer "priority", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["government_id"], name: "index_departments_on_government_id"
    t.index ["slug"], name: "index_departments_on_slug"
  end

  create_table "evidences", force: :cascade do |t|
    t.string "raw_gazette_notice_id"
    t.text "rias_summary"
    t.text "description_or_details"
    t.datetime "evidence_date"
    t.string "evidence_id"
    t.string "evidence_source_type"
    t.float "hybrid_linking_avg_confidence"
    t.string "hybrid_linking_method"
    t.datetime "hybrid_linking_timestamp"
    t.datetime "ingested_at"
    t.string "parliament_session_id"
    t.datetime "promise_linking_processed_at"
    t.string "promise_linking_status"
    t.integer "promise_links_found2"
    t.string "source_document_raw_id"
    t.string "source_url"
    t.text "title_or_summary"
    t.text "key_concepts", default: [], array: true
    t.text "linked_departments", default: [], array: true
    t.text "promise_ids", default: [], array: true
    t.jsonb "llm_analysis_raw", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "governments", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ministers", force: :cascade do |t|
    t.bigint "government_id", null: false
    t.bigint "department_id", null: false
    t.integer "order_of_precedence", null: false
    t.string "person_short_honorific", null: false
    t.datetime "started_at", precision: nil, null: false
    t.datetime "ended_at", precision: nil
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "title", null: false
    t.string "avatar_url"
    t.string "role", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_ministers_on_department_id"
    t.index ["government_id"], name: "index_ministers_on_government_id"
  end

  create_table "promises", force: :cascade do |t|
    t.string "promise_id"
    t.datetime "action_type_classified_at"
    t.integer "action_type_confidence"
    t.text "action_type_rationale"
    t.text "background_and_context"
    t.integer "bc_priority_score"
    t.string "bc_promise_direction"
    t.string "bc_promise_rank"
    t.text "bc_promise_rank_rationale"
    t.datetime "bc_ranked_at"
    t.string "candidate_or_government"
    t.string "category"
    t.string "concise_title"
    t.date "date_issued"
    t.text "description"
    t.integer "evidence_count"
    t.datetime "evidence_sync_fixed_at"
    t.datetime "explanation_enriched_at"
    t.string "explanation_enrichment_model"
    t.string "explanation_enrichment_status"
    t.datetime "history_generated_at"
    t.string "implied_action_type"
    t.datetime "ingested_at"
    t.string "keywords_context_used"
    t.datetime "keywords_enriched_at"
    t.string "keywords_enrichment_status"
    t.datetime "keywords_extracted_at"
    t.datetime "last_enrichment_at"
    t.datetime "last_evidence_date"
    t.datetime "last_progress_update_at"
    t.datetime "last_scored_at"
    t.datetime "last_updated_at"
    t.datetime "linking_preprocessing_done_at"
    t.datetime "linking_processed_at"
    t.string "linking_status"
    t.datetime "migration_status_ed_at"
    t.string "migration_version"
    t.string "parliament_session_id"
    t.string "party"
    t.string "party_code"
    t.integer "progress_score"
    t.integer "progress_score_1_to_5"
    t.string "progress_scoring_model"
    t.string "progress_status"
    t.text "progress_summary"
    t.datetime "rationale_format_fixed_at"
    t.string "region_code"
    t.string "responsible_department_lead"
    t.string "scoring_method"
    t.string "scoring_model"
    t.string "source_document_url"
    t.string "source_type"
    t.string "status"
    t.text "text"
    t.text "extracted_keywords_concepts", default: [], array: true
    t.text "intended_impact_and_objectives", default: [], array: true
    t.text "what_it_means_for_canadians", default: [], array: true
    t.text "linked_evidence_ids", default: [], array: true
    t.text "relevant_departments", default: [], array: true
    t.jsonb "commitment_history_rationale", default: {}
    t.jsonb "commitment_history_timeline", default: {}
    t.jsonb "key_points", default: {}
    t.jsonb "policy_areas", default: {}
    t.jsonb "target_groups", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "departments", "governments"
  add_foreign_key "ministers", "departments"
  add_foreign_key "ministers", "governments"
end
