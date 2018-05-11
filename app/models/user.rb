#
class User < ApplicationRecord
  before_save :default_values

  has_many :comments, dependent: :destroy
  has_many :devices, dependent: :destroy
  has_many :reactions, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :notification_from, class_name: 'Notification', foreign_key: :user_id_from, inverse_of: :user_target, dependent: :destroy
  has_one_attached :avatar

  enum status: {
    pending: 0,
    active: 1,
    suspended: -1,
    deleted: -2
  }.freeze

  validates :status, allow_nil: true, inclusion: { in: statuses }

  def default_values
    self.uuid ||= SecureRandom.uuid
    self.status ||= :pending
  end

  def reactions_count
    Reaction.active.where(user_id: id).count
  end

  def comments_count
    Comment.active.where(user_id: id).count
  end
end
