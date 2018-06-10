#
class Api::V1::Emotions::EmotionSerializer < Api::BaseSerializer
  attributes  :id,
              :name

  attribute :illustration do
    if object.illustration.attachment
      Rails.application.routes.url_helpers.rails_blob_url(object.illustration)
    end
  end
end
