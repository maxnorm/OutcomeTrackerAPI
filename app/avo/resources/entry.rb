class Avo::Resources::Entry < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  self.search = {
    query: -> { query.ransack(title_cont: params[:q], summary_cont: params[:q], url_cont: params[:q], m: "or").result(distinct: false) }
  }

  def fields
    field :id, as: :id
    field :is_index, as: :boolean

    field "proms", as: :number, only_on: :index do
      record.evidences.count
    end

    field "to_review", as: :number, only_on: :index do
      record.evidences.where(review: [ nil, false ]).count
    end

    field :feed, as: :belongs_to
    field :government, as: :belongs_to
    field :scraped_at, as: :date_time, sortable: true
    field :published_at, as: :date_time, sortable: true
    field :published_at, as: :date_time, sortable: true
    field :title, as: :text
    field :summary, as: :textarea
    field :evidences, as: :has_many
    field :url, as: :text
    field :skip_reason, as: :text
    field :skipped_at, as: :date_time
    field :activities, as: :has_many

    field :parsed_markdown, as: :markdown
  end

  def fill_fields
    super

    # Auto-populate government from the selected feed
    if record.feed.present? && record.government.blank?
      record.government = record.feed.government
    end
  end
end
