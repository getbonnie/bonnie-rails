# !
class Comment < ApplicationRecord
  attr_accessor :sound_base64

  after_create :set_attachment
  before_save :default_values
  after_commit :recount, on: %i[create update]
  after_commit :subscribe, on: %i[create]
  after_commit :unsubscribe, on: %i[destroy]
  after_commit :notify_users, on: %i[create update]

  belongs_to :user
  belongs_to :emotion
  belongs_to :pew
  belongs_to :comment, optional: true
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy, inverse_of: :likable
  has_many :plays, as: :playable, dependent: :destroy, inverse_of: :playable
  has_many :notifications, as: :notificationable, dependent: :destroy, inverse_of: :notificationable
  has_one_attached :sound

  enum status: {
    pending: 0,
    active: 1,
    deleted: -1
  }

  validates :status, allow_nil: true, inclusion: { in: statuses }

  def default_values
    self.uuid ||= SecureRandom.uuid
    self.status ||= :active
  end

  def recount
    return false if pew.nil?

    # Update count
    pew.update(
      comments_count: Comment.active.where(pew: pew).count
    )
  end

  private

  def set_attachment
    mime = 'audio/aac'

    return false unless decode_file(sound_base64, mime)

    sound.attach(
      io: File.open(filepath),
      filename: filename,
      content_type: mime
    )
    FileUtils.rm(filepath)
  end

  def notify_users
    notify_pew_author
    notify_reply
    notify_subscriptions
  end

  private

  def subscribe
    NotificationSubscription.where(pew: pew, user: user).first_or_create
  end

  def unsubscribe
    NotificationSubscription.where(pew: pew, user: user).delete_all
  end

  def notify_pew_author
    # No notification if the comment if from the Pew owner
    # No notification if it's a reply
    # No notification if the pew owner don't want to be notified
    return false if user.id == pew.user_id || comment_id.present? || !pew.notify

    Notification.create(
      kind: :comment,
      notificationable: self,
      from: user,
      user_id: pew.user_id,
      mode: :owner
    )
  end

  def notify_subscriptions
    # Build subscriptions
    subscriptions = NotificationSubscription.where(pew: pew)
                                            .where.not(user_id: pew.user_id)
                                            .where.not(user_id: user.id)

    subscriptions = subscriptions.where.not(user_id: comment.user_id) if comment_id.present?
    return false unless subscriptions.present?

    payload = []
    subscriptions.pluck(:user_id).each do |user_id|
      payload << {
        kind: :comment,
        notificationable: self,
        from: user,
        user_id: user_id,
        mode: :subscription
      }
    end
    return false unless payload.present?

    Notification.create(payload)
  end

  def notify_reply
    # Check if comment source exist and if notify?
    return false if comment_id.blank? || !comment.notify

    Notification.create(
      kind: :comment,
      notificationable: self,
      from: user,
      user_id: comment.user_id,
      mode: :reply
    )
  end
end
