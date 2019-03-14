#
class Emotion < ApplicationRecord
  before_save :default_values
  after_save :convert_base64

  has_many :comments, dependent: :destroy
  has_many :pews, dependent: :destroy

  acts_as_list

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

  def convert_base64
    return if url.blank?
    return if !saved_change_to_url? || emoji.blank?

    image = open(url)

    self.update_column(:emoji, Base64.strict_encode64(image.read))
  end

  def emoji_image
    "data:image/png;base64,#{emoji}"
  end
end
