# !
class Api::V1::PewsController < Api::V1::BaseController
  def index
    page = params.fetch(:page, 1)
    per = params.fetch(:per, 10)
    hashtag = params.fetch(:hashtag, nil)

    friends = current_user.following.pluck(:followed_id).push(current_user.id)

    pews = Pew.active.where(user_id: friends).order(id: :desc).page(page).per(per)
    pews = pews.joins(:hashtags).where('hashtags.lower_tag = ?', hashtag.downcase) if hashtag

    render  json: pews,
            root: :data,
            each_serializer: Api::V1::Pews::PewSerializer,
            meta: meta_attributes(pews),
            scope: pass_scope
  end

  def create
    pew_params = params.require(:pew).permit(
      :inline_hashtags,
      :emotion_id,
      :sound_base64,
      :duration
    ).tap do |i|
      i.require(:inline_hashtags)
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

  def update
    pew_params = params.require(:pew).permit(
      :inline_hashtags,
      :emotion_id
    )

    pew = Pew.active.find_by(uuid: params.fetch(:uuid), user: current_user)

    api_error(status: 404, errors: 'Pew missing') and return false unless pew

    pew.update(pew_params)

    render  json: pew.reload,
            root: :data,
            serializer: Api::V1::Pews::PewSerializer,
            scope: pass_scope
  end
end
