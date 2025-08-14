class StatcanDatasetsController < ApplicationController
  def show
    dataset = StatcanDataset.find_by(name: params[:id])
    render json: dataset
  end
end
