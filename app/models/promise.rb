class Promise < ApplicationRecord
  has_many :evidences, dependent: :destroy
  has_many :activities, through: :evidences
  has_many :entries, through: :activities

  has_many :department_promises, dependent: :destroy
  # has_many :relevant_departments, through: :department_promises, source: :department
  has_one :lead_department_promise, -> { where(is_lead: true) }, class_name: "DepartmentPromise"
  has_one :lead_department, through: :lead_department_promise, source: :department

  def link_department!(department, is_lead: false)
    Rails.logger.info("Linking department #{department.slug} to promise #{promise_id}")
    if is_lead
      lead_department_promise&.update(is_lead: false)
    end

    dp = department_promises.find_or_initialize_by(department: department)
    dp.is_lead = is_lead
    dp.save!
  end

  def format_for_llm
    {
      promise_id: promise_id,
      title: concise_title,
      description: description,
      text: text
    }
  end
end
