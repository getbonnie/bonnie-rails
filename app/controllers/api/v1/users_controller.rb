#
class Api::V1::UsersController < Api::V1::BaseController
  def show
    user = User.find_by(id: params[:id])
    api_error(status: 404, errors: 'User missing') and return false unless user

    render  json: user,
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
end
