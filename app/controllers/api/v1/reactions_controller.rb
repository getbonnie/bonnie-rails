#
class Api::V1::ReactionsController < Api::V1::BaseController
  def create
    params.require(:reaction).permit(:question_uuid, :emotion_id, :sound).tap do |i|
      i.require(:question_uuid)
      i.require(:emotion_id)
    end

    render json: true
  end
end
