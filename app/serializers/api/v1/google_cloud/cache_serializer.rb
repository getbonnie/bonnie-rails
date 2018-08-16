#
class Api::V1::GoogleCloud::CacheSerializer < Api::BaseSerializer
  has_many :emotions, serializer: Api::V1::Emotions::EmotionSerializer

  attribute :generated_at do
    Time.zone.today.to_s
  end

  def emotions
    Emotion.active
  end
end
