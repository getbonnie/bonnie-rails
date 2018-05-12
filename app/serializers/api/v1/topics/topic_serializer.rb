#
class Api::V1::Topics::TopicSerializer < Api::BaseSerializer
  belongs_to :category, serializer: Api::V1::Categories::CategorySerializer

  attributes  :uuid,
              :name,
              :content,
              :tag

  attribute :sticker do
    Rails.application.routes.url_helpers.rails_blob_url(object.sticker) if object.sticker.attachment
  end
end
