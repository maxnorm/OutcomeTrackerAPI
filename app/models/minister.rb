class Minister < ApplicationRecord
  belongs_to :government
  belongs_to :department

  def compound_name
    "#{title} (#{full_name})"
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
