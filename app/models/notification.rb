#
class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :from, class_name: 'User', foreign_key: :from_id, inverse_of: :notification_from

  enum kind: {
    comment: 1,
    like: 2
  }.freeze

  validates :kind, inclusion: { in: kinds }
end
