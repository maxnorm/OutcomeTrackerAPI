class Minister < ApplicationRecord
  belongs_to :government
  belongs_to :department
end
