#
class Comment < ApplicationRecord
  before_save :default_values

  belongs_to :user
  belongs_to :emotion
  belongs_to :reaction
  belongs_to :comment, optional: true
  has_many :comments, dependent: :destroy

  enum status: {
    pending: 0,
    active: 1,
    deleted: -1
  }

  validates :status, allow_nil: true, inclusion: { in: statuses }

  def default_values
    self.uuid ||= SecureRandom.uuid
    self.status ||= :pending
  end
end
