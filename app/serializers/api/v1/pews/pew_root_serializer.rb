# !
class Api::V1::Pews::PewRootSerializer < Api::BaseSerializer
  attributes  :uuid,
              :emotion_id,
              :likes_count,
              :comments_count,
              :duration,
              :hashtag,
              :created_at

  attribute :liked do
    if current_user
      object.likes.where(user: current_user).present?
    else
      false
    end
  end

  attribute :commented do
    if current_user
      object.comments.where(user: current_user).present?
    else
      false
    end
  end

  attribute :sound do
    Rails.application.routes.url_helpers.rails_blob_url(object.sound) if object.sound.attachment
  end

  attribute :played do
    if current_user
      object.plays.where(user_id: current_user.id).first.present?
    else
      false
    end
  end
end
