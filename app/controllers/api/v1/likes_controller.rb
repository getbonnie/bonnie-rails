#
class Api::V1::LikesController < Api::V1::BaseController
  def reaction
    reaction = Reaction.active
                       .where.not(user_id: current_user.id)
                       .find_by(uuid: params[:uuid])
    unless reaction
      api_error(status: 404, errors: 'Reaction missing') and return false
    end

    payload = {
      user_id: current_user.id,
      likable: reaction
    }
    like = Like.first_or_create(payload)

    # Deactivated for now (multiple likes)
    # like.increment!(:how_much)

    api_error(status: 500, errors: like.errors) and return false unless like.valid?

    render json: { data: true }
  end
end
