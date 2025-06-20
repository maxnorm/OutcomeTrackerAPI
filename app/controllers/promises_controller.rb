class PromisesController < ApplicationController
  def index
    @promises = Promise.all
    render json: @promises
  end

  def show
    @promise = Promise.find(params[:id])
  end
end
