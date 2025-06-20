class Avo::Resources::Entry < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :is_index, as: :boolean
    field :feed, as: :belongs_to
    field :scraped_at, as: :date_time, sortable: true
    field :published_at, as: :date_time, sortable: true
    field :published_at, as: :date_time, sortable: true
    field :title, as: :text
    field :promises, as: :has_many
    field :url, as: :text
    field :skip_reason, as: :text
    field :skipped_at, as: :date_time
    field :summary, as: :textarea
    field :activities, as: :has_many

    field :parsed_markdown, as: :markdown
  end
end
