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
    if current_user
      object.plays.where(user_id: current_user.id).first.present?
    else
      false
    end
  end

  attribute :liked do
    if current_user
      object.likes.where(user: current_user).present?
    else
      false
    end
  end
end
