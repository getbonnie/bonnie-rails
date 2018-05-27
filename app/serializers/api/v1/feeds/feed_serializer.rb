#
class Api::V1::Feeds::FeedSerializer < Api::BaseSerializer
  belongs_to :question, serializer: Api::V1::Questions::QuestionWithReactionsSerializer
  belongs_to :reaction, serializer: Api::V1::Reactions::ReactionBasicSerializer

  attributes :uuid, :kind, :created_at

  def question
    return [] unless object.feedable_type == 'Question'
    object.feedable
  end

  def reaction
    return [] unless object.feedable_type == 'Reaction'
    object.feedable
  end
end
