#
class Question < ApplicationRecord
  before_save :default_values

  belongs_to :topic
  belongs_to :category, optional: true
  has_many :reactions, dependent: :destroy

  enum status: {
    pending: 0,
    active: 1,
    deleted: -1
  }.freeze

  validates :short, presence: true
  validates :status, allow_nil: true, inclusion: { in: statuses }

  def default_values
    self.uuid ||= SecureRandom.uuid
    self.status ||= :pending
  end

  def reactions_count
    Reaction.active.where(question_id: id).count
  end
end
