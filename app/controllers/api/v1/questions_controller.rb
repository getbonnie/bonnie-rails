#
class Api::V1::QuestionsController < Api::V1::BaseController
  def reactions
    question = Question.active.find_by(uuid: params.fetch(:uuid))
    unless question
      api_error(status: 404, errors: 'Question missing') and return false
    end

    reactions = question.reactions.active.order(id: :desc)

    render  json: reactions,
            root: :data,
            each_serializer: Api::V1::Reactions::ReactionBasicSerializer,
            scope: pass_scope
  end
end
