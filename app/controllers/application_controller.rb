class ApplicationController < ActionController::Base
  def root
    render json: { message: "Welcome to the Outcome Tracker API! Check out the repo at https://github.com/BuildCanada/OutcomeTrackerAPI" }
  end
end
