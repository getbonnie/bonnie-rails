#
class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :user_from, class_name: 'User', foreign_key: :user_id_from, inverse_of: :notification_from

  TYPES = %i[
    comment
    like
  ].freeze

  validates :type_of, inclusion: { in: TYPES.map(&:to_s) }

  def self.types
    TYPES
  end
end
