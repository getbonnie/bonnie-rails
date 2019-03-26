# !
class Api::V1::EmotionsController < Api::V1::BaseController
  def index
    emotions = Emotion.active.order(position: :asc)

    render  json: emotions,
            root: :data,
            each_serializer: Api::V1::Emotions::EmotionSerializer
  end

  def manifest
    last_updated_emotion = Emotion.active.order(updated_at: :desc).first

    render  json: last_updated_emotion,
            root: :data,
            serializer: Api::V1::Emotions::EmotionManifestSerializer
  end
end
