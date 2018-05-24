#
class Api::V1::PlaysController < Api::V1::BaseController
  def reaction
    reaction = Reaction.active
                       .where.not(user_id: current_user.id)
                       .find_by(uuid: params.fetch(:uuid))
    unless reaction
      api_error(status: 404, errors: 'Reaction missing') and return false
    end

    payload = {
      user_id: current_user.id,
      playable: reaction
    }
    play = Play.create(payload)

    api_error(status: 500, errors: like.errors) and return false unless play.valid?

    render json: { data: true }
  end

  def comment
    comment = Comment.active
                     .find_by(uuid: params.fetch(:uuid))
    unless comment
      api_error(status: 404, errors: 'Comment missing') and return false
    end

    payload = {
      user_id: current_user.id,
      playable: comment
    }
    play = Play.create(payload)

    api_error(status: 500, errors: like.errors) and return false unless play.valid?

    render json: { data: true }
  end
end
