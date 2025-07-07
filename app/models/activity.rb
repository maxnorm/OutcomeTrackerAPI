class Activity < ApplicationRecord
  belongs_to :entry
  belongs_to :government

  has_many :evidences
  has_many :promises, through: :evidences

  def self.ransackable_attributes(auth_object = nil)
    [ "title" ]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
