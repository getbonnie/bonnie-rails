#
class Question < ApplicationRecord
  before_save :default_values
  after_commit :upload_cache

  belongs_to :topic
  belongs_to :category, optional: true
  belongs_to :classification, optional: true
  has_many :reactions, dependent: :destroy
  has_many :feeds, as: :feedable, dependent: :destroy, inverse_of: :feedable

  enum status: {
    pending: 0,
    active: 1,
    deleted: -1
  }.freeze

  enum kind: {
    classic: 1,
    trend: 2
  }.freeze

  validates :short, presence: true
  validates :status, allow_nil: true, inclusion: { in: statuses }
  validates :kind, allow_nil: true, inclusion: { in: kinds }

  def default_values
    self.uuid ||= SecureRandom.uuid
    self.status ||= :pending
    self.kind ||= :classic
  end

  def reactions_count
    Reaction.active.where(question_id: id).count
  end
end
