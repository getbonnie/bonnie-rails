#
class Feed < ApplicationRecord
  before_save :default_values

  belongs_to :feedable, polymorphic: true, optional: true

  enum kind: {
    new_question: 1,
    question_with_reactions: 2,
    reaction: 3
  }.freeze

  enum status: {
    deleted: -1,
    pending: 0,
    active: 1
  }.freeze

  FEEDABLE_TYPES = %w[
    Question
    Reaction
  ].freeze

  validates :feedable_type, allow_nil: true, inclusion: { in: FEEDABLE_TYPES }
  validates :kind, allow_nil: true, inclusion: { in: kinds }
  validates :status, allow_nil: true, inclusion: { in: statuses }

  def default_values
    self.uuid ||= SecureRandom.uuid
    self.status ||= :pending
  end
end
