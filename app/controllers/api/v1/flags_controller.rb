# !
class Api::V1::FlagsController < Api::V1::BaseController
  def create
    flag_params = params.require(:flag).permit(
      :pew_uuid,
      :comment_uuid,
      :kind
    ).tap do |i|
      i.require(:kind)
    end

    pew_uuid = flag_params.fetch(:pew_uuid, nil)
    comment_uuid = flag_params.fetch(:comment_uuid, nil)

    item = Pew.find_by(uuid: pew_uuid) if pew_uuid
    item = Comment.find_by(uuid: comment_uuid) if comment_uuid && !item
    api_error(status: 404, errors: 'Item missing') and return false unless item

    flag = Flag.create(
      user: current_user,
      flagable: item,
      kind: flag_params.fetch(:kind)
    )
    api_error(status: 500, errors: flag.errors) and return false unless flag.valid?

    render json: true
  end
end
