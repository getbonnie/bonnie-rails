#
class Api::V1::Topics::TopicSerializer < Api::BaseSerializer
  attributes  :id,
              :name,
              :content,
              :tag,
              :category_id

  attribute :sticker do
    Rails.application.routes.url_helpers.rails_blob_url(object.sticker) if object.sticker.attachment
  end
end
