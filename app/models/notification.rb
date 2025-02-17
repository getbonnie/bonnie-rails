# !
class Notification < ApplicationRecord
  before_save :default_values
  after_create :send_notifications
  after_create_commit :send_push

  belongs_to :user
  belongs_to :from, class_name: 'User', foreign_key: :from_id, inverse_of: :notification_from
  belongs_to :notificationable, polymorphic: true

  enum kind: {
    comment: 1,
    like: 2
  }.freeze

  enum mode: {
    owner: 1,
    reply: 2,
    subscription: 3
  }.freeze

  validates :kind, inclusion: { in: kinds }
  validates :mode, inclusion: { in: modes }

  def default_values
    self.uuid ||= SecureRandom.uuid
  end

  def phrase
    "#{from.name} #{action}"
  end

  private

  def action
    if kind == 'comment'
      if mode == 'owner'
        "a commenté votre Pew dans ##{notificationable.pew.first_hashtag}"
      elsif mode == 'subscription'
        "a également commenté un Pew dans ##{notificationable.pew.first_hashtag}"
      elsif mode == 'reply'
        "vous a répondu dans ##{notificationable.pew.first_hashtag}"
      end
    elsif kind == 'like'
      if notificationable_type == 'Pew'
        "a aimé votre Pew dans ##{notificationable.first_hashtag}"
      elsif notificationable_type == 'Comment'
        "a aimé votre commentaire dans ##{notificationable.pew.first_hashtag}"
      end
    end
  end

  def send_notifications
    return if !user.notify_likes && like?
    return if !user.notify_comments && comment?

    user.devices.each do |device|
      self.update(sent: true) if FcmLib.send_notification_success?(
        device.token,
        phrase,
        user.notifications.where(seen: false).count
      )
    end
  end

  def send_push
    FcmLib.send_to_topic("notification_#{user.uuid.gsub('-', '_')}", { reload: true }.as_json, :notifications)
  end
end
