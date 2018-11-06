#
class Emotion < ApplicationRecord
  before_save :default_values
  after_commit :upload_cache

  has_many :comments, dependent: :destroy
  has_many :pews, dependent: :destroy

  enum status: {
    pending: 0,
    active: 1,
    deleted: -1
  }.freeze

  validates :name, presence: true
  validates :status, allow_nil: true, inclusion: { in: statuses }

  def default_values
    self.status ||= :pending
  end

  def pews_count
    Pew.active.where(emotion_id: id).count
  end

  def comments_count
    Comment.active.where(emotion_id: id).count
  end
end
