#
class Api::V1::Reactions::ReactionSerializer < Api::BaseSerializer
  # belongs_to :question, serializer: Api::V3::Users::UserSmallItemSerializer

  attributes  :uuid,
              :emotion_id

  attribute :sound do
    Rails.application.routes.url_helpers.rails_blob_url(object.sound) if object.sound.attachment
  end
end
