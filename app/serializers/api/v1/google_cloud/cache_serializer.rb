#
class Api::V1::GoogleCloud::CacheSerializer < Api::BaseSerializer
  has_many :questions, serializer: Api::V1::Questions::QuestionSerializer
  has_many :emotions, serializer: Api::V1::Emotions::EmotionSerializer
  has_many :categories, serializer: Api::V1::Categories::CategorySerializer
  has_many :topics, serializer: Api::V1::Topics::TopicSerializer

  attribute :generated_at do
    Time.zone.today.to_s
  end

  def questions
    Question.active
  end

  def emotions
    Emotion.active
  end

  def topics
    Topic.active
  end

  def categories
    Category.active
  end
end
