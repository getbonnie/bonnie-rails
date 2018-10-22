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
    if kind == 'comment'
      if notificationable_type == 'Pew'
        "#{from.name} a commenté votre Pew dans ##{notificationable.hashtag}"
      elsif notificationable_type == 'Comment'
        "#{from.name} a répondu à votre commentaire d'un Pew dans ##{notificationable.pew.hashtag}"
      end
    elsif kind == 'like'
      if notificationable_type == 'Pew'
        "#{from.name} a aimé votre Pew dans ##{notificationable.hashtag}"
      elsif notificationable_type == 'Comment'
        "#{from.name} a aimé votre commentaire d'un Pew dans ##{notificationable.pew.hashtag}"
      end
    end
  end
end
