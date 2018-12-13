# !
class Like < ApplicationRecord
  after_create :notify
  after_commit :recount

  belongs_to :user
  belongs_to :likable, polymorphic: true
  has_many :notifications, as: :notificationable, dependent: :destroy, inverse_of: :notificationable

  LIKABLE_TYPES = %w[
    Pew
    Comment
  ].freeze

  validates :likable_type, inclusion: { in: LIKABLE_TYPES }

  def self.likable_types
    LIKABLE_TYPES
  end

  def recount
    return false if likable.destroyed?

    counter = Like.unscoped
                  .where(likable_type: likable.class.name)
                  .where(likable_id: likable.id).count

    # Update count
    likable.update(
      likes_count: counter
    )
  end

  def notify
    current_user = user

    if likable_type == 'Pew'
      Notification.create(
        kind: :like,
        notificationable: likable,
        from: current_user,
        user_id: likable.user_id,
        mode: :owner
      )
    end

    return false unless likable_type == 'Comment'

    Notification.create(
      kind: :like,
      notificationable: likable,
      from: current_user,
      user_id: likable.user_id,
      mode: :owner
    )
  end
end
