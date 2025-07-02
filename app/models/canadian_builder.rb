class CanadianBuilder < ApplicationRecord
  belongs_to :government

  validates :name, presence: true
  validates :title, presence: true
  validates :location, presence: true
  validates :category, presence: true
  validates :description, presence: true
  validates :achievement, presence: true
  validates :avatar, presence: true
  validates :website, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), message: "must be a valid URL" }, allow_blank: true

  before_validation :generate_slug, on: :create

  private

  def generate_slug
    self.slug = name.parameterize if name.present?
  end
end
