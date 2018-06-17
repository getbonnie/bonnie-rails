#
class Api::V1::LikesController < Api::V1::BaseController
  before_action :fetch_source, only: %i[create delete]

  def create
    like = Like.first_or_create(@payload)

    api_error(status: 500, errors: like.errors) and return false unless
      like.valid?

    render json: { data: true }
  end

  def delete
    like = Like.find_by(@payload)

    api_error(status: 500, errors: 'Like missing') and return false unless
      like.present?

    like.destroy

    render json: { data: true }
  end

  private

  def fetch_source
    api_error(status: 500, errors: 'Wrong type') and return false unless
      Like.likable_types.include? params.fetch(:type).capitalize

    @object = if params.fetch(:type) == 'pew'
                fetch_pew
              elsif params.fetch(:type) == 'comment'
                fetch_comment
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
