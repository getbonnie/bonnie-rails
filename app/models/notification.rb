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
      if notificationable_type == 'Pew'
        "commenté votre Pew dans ##{notificationable.hashtag}"
      elsif notificationable_type == 'Comment'
        "répondu à votre commentaire d'un Pew dans ##{notificationable.pew.hashtag}"
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
