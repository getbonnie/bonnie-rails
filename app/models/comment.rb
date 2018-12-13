# !
class Comment < ApplicationRecord
  attr_accessor :sound_base64

  after_create :set_attachment
  before_save :default_values
  after_commit :recount, on: %i[create update]
  after_commit :subscribe, on: %i[create]
  after_commit :unsubscribe, on: %i[destroy]
  after_commit :notify, on: %i[create update]

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

  def notify
    current_user = user
    current_pew = pew

    # No notification for the Pew owner
    if current_user.id != current_pew.user_id && comment_id.blank?
      Notification.create(
        kind: :comment,
        notificationable: self,
        from: current_user,
        user_id: current_pew.user_id
      )
    end

    return false if comment_id.blank?

    Notification.create(
      kind: :comment,
      notificationable: self,
      from: current_user,
      user_id: comment.user_id
    )
  end

  def subscribe
    NotificationSubscription.where(pew: pew, user: user).first_or_create
  end

  def unsubscribe
    NotificationSubscription.where(pew: pew, user: user).delete_all
  end
end
