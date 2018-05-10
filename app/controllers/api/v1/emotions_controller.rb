#
class Api::V1::EmotionsController < Api::V1::BaseController
  def index
    emotions = Emotion.page(1).per(100)

    render  json: emotions,
            root: :data,
            each_serializer: Api::V1::Emotions::EmotionSerializer,
            meta: meta_attributes(emotions),
            scope: pass_scope
  end
end
