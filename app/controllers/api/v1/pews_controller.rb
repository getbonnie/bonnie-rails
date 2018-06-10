#
class Api::V1::PewsController < Api::V1::BaseController
  def index
    page = params.fetch(:page, 1)
    per = params.fetch(:per, 10)
    hashtag = params.fetch(:hashtag, nil)

    pews = Pew.active.order(id: :desc).page(page).per(per)
    pews = pews.where(hashtag: hashtag) if hashtag

    render  json: pews,
            root: :data,
            each_serializer: Api::V1::Pews::PewSerializer,
            meta: meta_attributes(pews),
            scope: pass_scope
  end

  def create
    pew_params = params.require(:pew).permit(:emotion_id, :sound).tap do |i|
      i.require(:emotion_id)
      i.require(:sound)
    end

    payload = {
      emotion_id: pew_params.fetch(:emotion_id),
      sound: pew_params.fetch(:sound),
      user_id: current_user.id
    }

    pew = Pew.create(payload)
    api_error(status: 500, errors: 'Error during creation') and return false unless
      pew.valid?

    render  json: pew,
            root: :data,
            serializer: Api::V1::Pews::PewSerializer,
            scope: pass_scope
  end

  def show
    pew = Pew.active.find_by(uuid: params.fetch(:uuid))
    unless pew
      api_error(status: 404, errors: 'Pew missing') and return false
    end

    render  json: pew,
            root: :data,
            serializer: Api::V1::Pews::PewSerializer,
            scope: pass_scope
  end

end
