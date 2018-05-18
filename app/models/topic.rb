#
class Topic < ApplicationRecord
  before_save :default_values
  after_commit :upload_cache

  belongs_to :category, optional: true
  has_many :questions, dependent: :destroy
  has_one_attached :sticker

  enum status: {
    pending: 0,
    active: 1,
    archived: -1,
    deleted: -2
  }.freeze

  validates :name, presence: true
  validates :status, allow_nil: true, inclusion: { in: statuses }

  def default_values
    self.uuid ||= SecureRandom.uuid
    self.status ||= :pending
  end

  def questions_count
    Question.active.where(topic_id: id).count
  end
end
