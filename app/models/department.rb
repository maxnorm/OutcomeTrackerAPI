class Department < ApplicationRecord
  belongs_to :government
  has_many :ministers

  has_many :department_promises, dependent: :destroy
  has_many :promises, through: :department_promises
  has_many :lead_promises, -> { where(department_promises: { is_lead: true }) },
           through: :department_promises, source: :promise
end
