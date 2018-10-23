# !
class Api::V1::Comments::CommentRootSerializer < Api::BaseSerializer
  attributes  :uuid,
              :emotion_id,
              :created_at,
              :likes_count,
              :duration

  attribute :sound do
    if object.sound.attachment
      Rails.application.routes.url_helpers.rails_blob_url(object.sound)
    end
  end

  attribute :played do
    object.plays.where(user_id: current_user.id).first.present?
  end

  attribute :liked do
    object.likes.where(user: current_user).present?
  end
end
