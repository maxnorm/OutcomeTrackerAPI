class Evidence < ApplicationRecord
  belongs_to :activity
  belongs_to :promise
  belongs_to :linked_by, class_name: "User", optional: true
  belongs_to :reviewed_by, class_name: "User", optional: true

  def self.ransackable_attributes(auth_object = nil)
    [ "impact", "impact_reason", "link_reason", "link_type" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "promise", "activity" ]
  end

  after_commit do
    self.promise.set_last_evidence_date!
  end

  def search_result_title
    "Re: Promise #{promise&.concise_title} - #{activity&.title}"
  end
end
