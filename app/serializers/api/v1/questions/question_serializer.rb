#
class Api::V1::Questions::QuestionSerializer < Api::BaseSerializer
  belongs_to :topic, serializer: Api::V1::Topics::TopicSerializer

  attributes  :uuid,
              :short,
              :long
end
