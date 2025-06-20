class Department < ApplicationRecord
  belongs_to :government
  has_many :officials, class_name: "Minister", dependent: :destroy
  has_one :minister, -> { where(role: "Minister") }, class_name: "Minister"


  has_many :department_promises, dependent: :destroy
  has_many :promises, through: :department_promises
  has_many :lead_promises, -> { where(department_promises: { is_lead: true }) },
           through: :department_promises, source: :promise
end
