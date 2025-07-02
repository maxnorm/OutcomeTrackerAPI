class BuildersController < ApplicationController
  before_action :set_canadian_builder, only: %i[ show ]

  # GET /builders
  def index
    @canadian_builders = CanadianBuilder.order(:name)
    render json: @canadian_builders.as_json(only: [ :id, :name, :title, :location, :description, :category, :slug ])
  end

  # GET /builders/1
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_canadian_builder
      id = params.expect(:id)
      if id.match(/[0-9]/)
        @canadian_builder = CanadianBuilder.find(id)
      else
        @canadian_builder = CanadianBuilder.find_by(slug: id)
      end
    end
end
