#
class RootController < ApplicationController
  def index
    emotions = Emotion.active.page(1).per(1).order(position: :asc)

    render  json: emotions,
            root: :data,
            each_serializer: Api::V1::Emotions::EmotionSerializer
  end
end
