#
class Api::V1::Emotions::EmotionSerializer < Api::BaseSerializer
  attributes  :id,
              :emoji_image
end
