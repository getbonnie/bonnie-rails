# !
class Api::V1::Comments::CommentSerializer < Api::BaseSerializer
  belongs_to :in_reply_to, serializer: Api::V1::Comments::ReplySerializer
  belongs_to :user, serializer: Api::V1::Users::UserSerializer

  attributes  :uuid,
              :emotion_id,
              :created_at

  attribute :sound do
    if object.sound.attachment
      Rails.application.routes.url_helpers.rails_blob_url(object.sound)
    end
  end

  attribute :played do
    object.plays.where(user_id: current_user.id).first.present?
  end

  def in_reply_to
    object.comment if object.comment_id.present?
  end
end
