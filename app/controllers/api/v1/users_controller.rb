#
class Api::V1::UsersController < Api::V1::BaseController
  def me
    render json: true
  end
end
