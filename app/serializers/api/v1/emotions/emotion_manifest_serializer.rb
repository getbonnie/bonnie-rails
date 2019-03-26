#
class Api::V1::Emotions::EmotionManifestSerializer < Api::BaseSerializer
  attribute :manifest do
    require 'digest'

    "#{Digest::MD5.hexdigest(object.id.to_s + object.created_at.to_s)}"
  end
end
