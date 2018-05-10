#
class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :user_from, class_name: 'User', foreign_key: :user_id_from, inverse_of: :notification_from

  enum type: {
    comment: 1,
    like: 2
  }.freeze

  validates :type, inclusion: { in: types }
end
