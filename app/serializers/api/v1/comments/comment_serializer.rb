# !
class Api::V1::Comments::CommentSerializer < Api::V1::Comments::CommentRootSerializer
  belongs_to :in_reply_to, serializer: Api::V1::Comments::ReplySerializer
  belongs_to :user, serializer: Api::V1::Users::UserSerializer

  def in_reply_to
    object.comment if object.comment_id.present?
  end
end
