#
class Api::V1::CommentsController < Api::V1::BaseController
  before_action :load_reaction, only: %i[index_reactions create_reaction]

  def index_reactions
    comments = @reaction.comments.active.order(id: :desc)

    render  json: comments,
            root: :data,
            each_serializer: Api::V1::Comments::CommentSerializer,
            scope: pass_scope
  end

  def create_reaction
    comment_params = params.require(:comment).permit(
      :sound,
      :comment_uuid,
      :emotion_id
    ).tap do |i|
      i.require(:sound)
      i.require(:emotion_id)
    end

    comment_id = nil
    if comment_params.fetch(:comment_uuid, nil)
      parent_comment = Comment.active
                              .where(reaction_id: @reaction.id)
                              .find_by(uuid: comment_params.fetch(:comment_uuid))

      if parent_comment.blank?
        api_error(status: 500, errors: 'Previous comment missing') and return false
      end

      comment_id = parent_comment.id
    end

    payload = {
      user_id: current_user.id,
      reaction_id: @reaction.id,
      comment_id: comment_id,
      emotion_id: comment_params.fetch(:emotion_id),
      sound: comment_params.fetch(:sound)
    }
    comment = Comment.create(payload)

    api_error(status: 500, errors: comment.errors) and return false unless comment.valid?

    render  json: comment,
            root: :data,
            serializer: Api::V1::Comments::CommentSerializer,
            scope: pass_scope
  end

  private

  def load_reaction
    @reaction = Reaction.active.find_by(uuid: params.fetch(:uuid))

    return if @reaction
    api_error(status: 404, errors: 'Reaction missing') and return false
  end
end
