class Department < ApplicationRecord
  belongs_to :government
  has_many :ministers
end
