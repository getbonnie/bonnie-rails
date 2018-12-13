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
    subject + verb
  end

  private

  def subject
    if from.id == user.id
      'Vous avez '
    else
      "#{from.name} a "
    end
  end

  def verb
    if kind == 'comment'
      if mode == 'owner'
        "commenté votre Pew dans ##{notificationable.pew.hashtag}"
      elsif mode == 'subscription'
        "également commenté un Pew dans ##{notificationable.pew.hashtag}"
      elsif mode == 'reply'
        "vous a répondu dans ##{notificationable.pew.hashtag}"
      end
    elsif kind == 'like'
      if notificationable_type == 'Pew'
        "aimé votre Pew dans ##{notificationable.hashtag}"
      elsif notificationable_type == 'Comment'
        "aimé votre commentaire d'un Pew dans ##{notificationable.pew.hashtag}"
      end
    end
  end
end
