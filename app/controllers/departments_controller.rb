class DepartmentsController < ApplicationController
  before_action :set_department, only: %i[ show ]

  # GET /departments`
  def index
    @departments = Department.all

    render json: @departments
  end

  # GET /departments/1
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_department
      id = params.expect(:id)
      if id.match(/[0-9]/)
        @department = Department.find(id)
      else
        @department = Department.find_by(slug: id)
      end
    end
end
