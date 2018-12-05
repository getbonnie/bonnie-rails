# !
class Api::V1::Notifications::NotificationSerializer < Api::BaseSerializer
  belongs_to :from, serializer: Api::V1::Users::UserSerializer
  belongs_to :pew, serializer: Api::V1::Pews::PewRootSerializer
  belongs_to :comment, serializer: Api::V1::Comments::CommentRootSerializer

  attributes  :uuid,
              :kind,
              :created_at,
              :seen,
              :sent,
              :clicked,
              :phrase

  attribute :comment_position do
    if object.notificationable_type == 'Comment'
      object.notificationable.pew.comments.where(' id <= ? ', object.notificationable.id).count
    else
      0
    end
  end

  def pew
    if object.notificationable_type == 'Pew'
      object.notificationable
    elsif object.notificationable_type == 'Comment'
      object.notificationable.pew
    end
  end

  def comment
    return nil unless object.notificationable_type == 'Comment'

    object.notificationable
  end
end
