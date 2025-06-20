class Avo::Resources::Department < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }
  self.title = :official_name

  def fields
    field :government_id, as: :number
    field :slug, as: :text
    field :official_name, as: :text
    field :display_name, as: :text
    field :priority, as: :number
    field :government, as: :belongs_to
    field :ministers, as: :has_many
    field :lead_promises, as: :has_many

    field :promises, as: :has_many
  end
end
