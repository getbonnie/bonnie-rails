#
class Comment < ApplicationRecord
  before_save :default_values

  belongs_to :user
  belongs_to :emotion
  belongs_to :pew
  belongs_to :comment, optional: true
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy, inverse_of: :likable
  has_many :plays, as: :playable, dependent: :destroy, inverse_of: :playable
  has_one_attached :sound

  enum status: {
    pending: 0,
    active: 1,
    deleted: -1
  }

  validates :status, allow_nil: true, inclusion: { in: statuses }

  def default_values
    self.uuid ||= SecureRandom.uuid
    self.status ||= :active
  end
end
