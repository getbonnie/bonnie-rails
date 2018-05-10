#
class Api::V1::Emotions::EmotionSerializer < Api::BaseSerializer
  attributes  :id,
              :name

  attribute :illustration do
    Rails.application.routes.url_helpers.rails_blob_url(object.illustration) if object.illustration.attachment
  end
end
