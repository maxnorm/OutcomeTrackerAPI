class MinistersController < ApplicationController
  before_action :set_minister, only: %i[ show ]

  # GET /ministers
  def index
    @ministers = Minister.all

    render json: @ministers
  end

  # GET /ministers/1
  def show
    render json: @minister
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_minister
      @minister = Minister.find(params.expect(:id))
    end
end
