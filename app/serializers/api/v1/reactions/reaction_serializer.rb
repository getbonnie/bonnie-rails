#
class Api::V1::Reactions::ReactionSerializer < Api::BaseSerializer
  belongs_to :question, serializer: Api::V1::Questions::QuestionSerializer
  belongs_to :user, serializer: Api::V1::Users::UserSerializer

  attributes  :uuid,
              :emotion_id,
              :likes_count,
              :comments_count,
              :created_at

  attribute :sound do
    Rails.application.routes.url_helpers.rails_blob_url(object.sound) if object.sound.attachment
  end

  attribute :played do
    object.plays.where(user_id: current_user.id).first.present?
  end
end
