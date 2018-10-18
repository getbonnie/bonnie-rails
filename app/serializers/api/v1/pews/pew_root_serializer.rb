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
    object.likes.where(user: current_user).present?
  end

  attribute :played do
    object.plays.where(user: current_user).present?
  end

  attribute :sound do
    Rails.application.routes.url_helpers.rails_blob_url(object.sound) if object.sound.attachment
  end

  attribute :played do
    object.plays.where(user_id: current_user.id).first.present?
  end
end
