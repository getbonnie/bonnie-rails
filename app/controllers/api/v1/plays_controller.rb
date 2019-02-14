# !
class Api::V1::PlaysController < Api::V1::BaseController
  before_action :fetch_source, only: %i[create]

  def create
    payload = {
      user_id: current_user.id,
      playable: @object
    }
    play = Play.where(payload).first_or_create

    api_error(status: 500, errors: play.errors) and return false unless play.valid?

    # Update count
    play.playable.increment!(:plays_count)

    render json: { data: true }
  end

  private

  def fetch_source
    api_error(status: 500, errors: 'Wrong type') and return false unless
      Play.playable_types.include? params.fetch(:type).capitalize

    @object = if params.fetch(:type) == 'pew'
                fetch_pew
              else
                fetch_comment
              end

    api_error(status: 500, errors: 'Object missing') and return false if @object.blank?
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
