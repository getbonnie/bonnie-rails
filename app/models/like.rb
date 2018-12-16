# !
class Like < ApplicationRecord
  after_create :notify_users
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

  private

  def notify_users
    notify_pew
    notify_comment
  end


  def notify_pew
    return false unless likable_type == 'Pew' && likable.user_id != user.id

    Notification.create(
      kind: :like,
      notificationable: likable,
      from: user,
      user_id: likable.user_id,
      mode: :owner
    )
  end

  def notify_comment
    return false unless likable_type == 'Comment' && likable.user_id != user.id

    Notification.create(
      kind: :like,
      notificationable: likable,
      from: user,
      user_id: likable.user_id,
      mode: :owner
    )
  end
end
