# !
class Api::V1::LikesController < Api::V1::BaseController
  before_action :fetch_source, only: %i[create delete]

  def create
    like = Like.where(@payload).first_or_create

    api_error(status: 500, errors: like.errors) and return false unless
      like.valid?

    render  json: @object.reload,
            root: :data,
            serializer: @serializer,
            scope: pass_scope
  end

  def delete
    like = Like.find_by(@payload)

    api_error(status: 500, errors: 'Like missing') and return false if
      like.blank?

    like.destroy

    render  json: @object.reload,
            root: :data,
            serializer: @serializer,
            scope: pass_scope
  end

  private

  def fetch_source
    api_error(status: 500, errors: 'Wrong type') and return false unless
      Like.likable_types.include? params.fetch(:type).capitalize

    if params.fetch(:type) == 'pew'
      @object = fetch_pew
      @serializer = Api::V1::Pews::PewCountsSerializer
    elsif params.fetch(:type) == 'comment'
      @object = fetch_comment
      @serializer = Api::V1::Comments::CommentCountsSerializer
    end

    @payload = {
      user_id: current_user.id,
      likable: @object
    }
  end

  def fetch_pew
    Pew.active
       .find_by(uuid: params.fetch(:uuid))
  end

  def fetch_comment
    Comment.active
           .find_by(uuid: params.fetch(:uuid))
  end
end
