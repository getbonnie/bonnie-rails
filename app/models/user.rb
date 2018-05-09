#
class User < ApplicationRecord
  before_save :default_values

  has_many :comments, dependent: :destroy
  has_many :devices, dependent: :destroy
  has_many :reactions, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :notification_from, class_name: 'Notification', foreign_key: :user_id_from, inverse_of: :user_target, dependent: :destroy
  has_one_attached :avatar

  STATES = %i[
    pending
    active
    suspended
    deleted
  ].freeze

  validates :state, allow_nil: true, inclusion: { in: STATES.map(&:to_s) }

  def default_values
    self.uuid ||= SecureRandom.uuid
    self.state ||= 'pending'
  end

  def self.states
    STATES
  end
end
