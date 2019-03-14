# !
class Api::V1::EmotionsController < Api::V1::BaseController
  def index
    emotions = Emotion.active.order(position: :asc)

    render  json: emotions,
            root: :data,
            each_serializer: Api::V1::Emotions::EmotionSerializer
  end
end
