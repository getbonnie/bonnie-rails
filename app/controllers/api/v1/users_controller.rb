#
class Api::V1::UsersController < Api::V1::BaseController
  def me
    user = User.find_by(id: current_user.id)
    api_error(status: 404, errors: 'User missing') and return false unless user

    render  json: user,
            root: :data,
            serializer: Api::V1::Users::UserSerializer,
            scope: pass_scope
  end
end
