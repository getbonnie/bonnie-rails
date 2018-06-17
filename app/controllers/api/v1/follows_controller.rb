#
class Api::V1::FollowsController < Api::V1::BaseController
  before_action :fetch_user, only: %i[create delete]

  def create
    follows = Follower.first_or_create(@payload)

    api_error(status: 500, errors: follows.errors) and return false unless
      follows.valid?

    render json: { data: true }
  end

  def delete
    follows = Follower.find_by(@payload)

    api_error(status: 500, errors: 'Like missing') and return false if
      follows.blank?

    follows.destroy

    render json: { data: true }
  end

  private

  def fetch_user
    user = User.where.not(id: current_user.id).find_by(uuid: params.fetch(:uuid))
    api_error(status: 500, errors: 'User missing') and return false unless user

    @payload = {
      user_id: current_user.id,
      following: user
    }
  end
end
