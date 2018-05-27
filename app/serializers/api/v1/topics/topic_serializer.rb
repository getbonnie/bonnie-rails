#
class Api::V1::Topics::TopicSerializer < Api::BaseSerializer
  has_many :questions, serializer: Api::V1::Questions::QuestionBasicSerializer

  attributes  :uuid,
              :name,
              :content,
              :tag,
              :category_id

  attribute :sticker do
    Rails.application.routes.url_helpers.rails_blob_url(object.sticker) if object.sticker.attachment
  end
end
