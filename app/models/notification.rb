# !
class Notification < ApplicationRecord
  before_save :default_values

  belongs_to :user
  belongs_to :from, class_name: 'User', foreign_key: :from_id, inverse_of: :notification_from
  belongs_to :notificationable, polymorphic: true

  enum kind: {
    comment: 1,
    like: 2
  }.freeze

  validates :kind, inclusion: { in: kinds }

  def default_values
    self.uuid ||= SecureRandom.uuid
  end
end
