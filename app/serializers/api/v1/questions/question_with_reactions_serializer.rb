#
class Api::V1::Questions::QuestionWithReactionsSerializer < Api::BaseSerializer
  has_many :reactions, serializer: Api::V1::Reactions::ReactionBasicSerializer

  attributes  :uuid,
              :short,
              :long

  def reactions
    object.reactions.active.order(id: :desc).limit(5)
  end
end
