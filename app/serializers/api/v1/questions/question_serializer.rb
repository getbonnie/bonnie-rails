#
class Api::V1::Questions::QuestionSerializer < Api::BaseSerializer
  attributes  :id,
              :topic_id,
              :short,
              :long
end
