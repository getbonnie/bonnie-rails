#
class Api::V1::Emotions::EmotionSerializer < Api::BaseSerializer
  attributes  :id,
              :name,
              :url
end
