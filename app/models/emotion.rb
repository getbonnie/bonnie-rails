#
class Emotion < ApplicationRecord
  before_save :default_values

  has_many :comments, dependent: :destroy
  has_many :reactions, dependent: :destroy
  has_one_attached :illustration

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

  def reactions_count
    Reaction.active.where(emotion_id: id).count
  end

  def comments_count
    Comment.active.where(emotion_id: id).count
  end
end
