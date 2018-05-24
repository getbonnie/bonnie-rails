#
class Api::V1::ReactionsController < Api::V1::BaseController
  def create
    reaction_params = params.require(:reaction).permit(:question_uuid, :emotion_id, :sound).tap do |i|
      i.require(:question_uuid)
      i.require(:emotion_id)
      i.require(:sound)
    end

    payload = {
      question_id: Question.find_by(uuid: reaction_params.fetch(:question_uuid)).id,
      emotion_id: reaction_params.fetch(:emotion_id),
      sound: reaction_params.fetch(:sound),
      user_id: current_user.id
    }
    reaction = Reaction.create(payload)
    api_error(status: 500, errors: 'Error during creation') and return false unless reaction.valid?

    render  json: reaction,
            root: :data,
            serializer: Api::V1::Reactions::ReactionSerializer,
            scope: pass_scope
  end

  def show
    reaction = Reaction.active.find_by(uuid: params.fetch(:uuid))
    unless reaction
      api_error(status: 404, errors: 'Reaction missing') and return false
    end

    render  json: reaction,
            root: :data,
            serializer: Api::V1::Reactions::ReactionSerializer,
            scope: pass_scope
  end
end
