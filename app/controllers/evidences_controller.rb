class EvidencesController < ApplicationController
  def index
    @evidences = Evidence.all
    render json: @evidences
  end

  def show
    @evidence = Evidence.find(params[:id])
    render json: @evidence
  end
end
