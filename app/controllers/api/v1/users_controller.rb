#
class Api::V1::UsersController < Api::V1::BaseController
  before_action :fetch_user, only: %i[show questions reactions]

  def show
    render  json: @user,
            root: :data,
            serializer: Api::V1::Users::UserSerializer,
            scope: pass_scope
  end

  def me
    user = User.find_by(id: current_user.id)
    api_error(status: 404, errors: 'User missing') and return false unless user

    render  json: user,
            root: :data,
            serializer: Api::V1::Users::MeSerializer,
            scope: pass_scope
  end

  def update
    user_params = params.require(:user).permit(
      :name,
      :birthdate,
      :latitude,
      :longitude,
      :notify_ads,
      :notify_comments,
      :notify_features,
      :notify_likes,
      :avatar
    )

    user = User.find_by(id: current_user.id)
    api_error(status: 404, errors: 'User missing') and return false unless user

    user.update(user_params)
    api_error(status: 500, errors: user.errors) and return false unless user.valid?

    render  json: user,
            root: :data,
            serializer: Api::V1::Users::UserSerializer,
            scope: pass_scope
  end

  def reactions
    page = params.fetch(:page, 1)
    per = params.fetch(:per, 10)
    reactions = @user.reactions.order(created_at: :desc).page(page).per(per)

    render  json: reactions,
            root: :data,
            each_serializer: Api::V1::Reactions::ReactionSerializer,
            meta: meta_attributes(reactions),
            scope: pass_scope
  end

  private

  def fetch_user
    @user = User.find_by(uuid: params[:uuid])
    api_error(status: 404, errors: 'User missing') and return false unless @user
  end
end
