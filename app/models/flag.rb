#
class Flag < ApplicationRecord
  before_save :default_values

  belongs_to :user
  belongs_to :flagable, polymorphic: true

  enum kind: {
    rules: 1,
    behavior: 2,
    spam: 3
  }.freeze

  enum status: {
    pending: 0,
    moderated: 1
  }.freeze

  FLAGABLE_TYPES = %w[
    Pew
    Comment
  ].freeze

  validates :flagable_type, inclusion: { in: FLAGABLE_TYPES }
  validates :status, allow_nil: true, inclusion: { in: statuses }
  validates :kind, allow_nil: true, inclusion: { in: kinds }

  def default_values
    self.status ||= :pending
  end
end
