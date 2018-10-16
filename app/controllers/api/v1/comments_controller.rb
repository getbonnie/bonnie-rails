# !
class Api::V1::CommentsController < Api::V1::BaseController
  before_action :fetch_pew, only: %i[index create]
  before_action :fetch_comment, only: %i[create]

  def index
    page = params.fetch(:page, 1)
    per = params.fetch(:per, 10)
    comments = @pew.comments.active.order(id: :asc).page(page).per(per)

    render  json: comments,
            root: :data,
            each_serializer: Api::V1::Comments::CommentSerializer,
            meta: meta_attributes(comments),
            scope: pass_scope
  end

  def create
    payload = {
      user_id: current_user.id,
      pew_id: @pew.id,
      comment_id: @comment_id,
      emotion_id: @comment_params.fetch(:emotion_id),
      duration: @comment_params.fetch(:duration),
      sound_base64: @comment_params.fetch(:sound_base64, nil)
    }
    comment = Comment.create(payload)

    api_error(status: 500, errors: comment.errors) and return false unless
      comment.valid?

    render  json: comment,
            root: :data,
            serializer: Api::V1::Comments::CommentSerializer,
            scope: pass_scope
  end

  private

  def fetch_pew
    @pew = Pew.active.find_by(uuid: params.fetch(:uuid))

    return if @pew

    api_error(status: 404, errors: 'Pew missing') and return false
  end

  def fetch_comment
    @comment_params = params.require(:comment).permit(
      :sound_base64,
      :comment_uuid,
      :emotion_id,
      :duration
    ).tap do |i|
      i.require(:sound_base64) unless Rails.env.development?
      i.require(:emotion_id)
      i.require(:duration)
    end

    comment_uuid = @comment_params.fetch(:comment_uuid, nil)
    @comment_id = nil

    return unless comment_uuid

    parent_comment = Comment.active
                            .where(pew_id: @pew.id)
                            .find_by(uuid: comment_uuid)

    api_error(status: 500, errors: 'Prev comment missing') and return false if parent_comment.blank?

    @comment_id = parent_comment.id
  end
end
