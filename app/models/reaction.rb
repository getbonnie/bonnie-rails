#
class Reaction < ApplicationRecord
  before_save :default_values

  belongs_to :question
  belongs_to :user
  belongs_to :emotion
  has_many :comments, dependent: :destroy
  has_one_attached :sound

  enum status: {
    pending: 0,
    active: 1,
    deleted: -1
  }.freeze

  validates :status, allow_nil: true, inclusion: { in: statuses }

  def default_values
    self.uuid ||= SecureRandom.uuid
    self.status ||= :pending
  end
end
