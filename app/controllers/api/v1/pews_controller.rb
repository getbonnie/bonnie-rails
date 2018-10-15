# !
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
    pew_params = params.require(:pew).permit(
      :hashtag,
      :emotion_id,
      :sound_base64,
      :duration
    ).tap do |i|
      i.require(:hashtag)
      i.require(:emotion_id)
      i.require(:duration)
      i.require(:sound_base64) unless Rails.env.development?
    end

    payload = pew_params.merge(user_id: current_user.id)

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
    api_error(status: 404, errors: 'Pew missing') and return false unless pew

    render  json: pew,
            root: :data,
            serializer: Api::V1::Pews::PewSerializer,
            scope: pass_scope
  end

  def delete
    pew = Pew.active.find_by(uuid: params.fetch(:uuid), user: current_user)

    api_error(status: 404, errors: 'Pew missing') and return false unless pew

    pew.destroy

    render json: { data: true }
  end
end
