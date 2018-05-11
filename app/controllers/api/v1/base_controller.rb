#
class Api::V1::BaseController < Api::BaseController
  before_action :authenticate_request!

  protected

  def current_user
    @user_id.nil? ? @current_user : User.find(@user_id)
  end

  # Validates the token and user and sets the @current_user scope
  def authenticate_request!
    # Bypass for env != production
    @user_id = request.headers['user']
    # return nil if @user_id && !Rails.env.production?
    return nil if @user_id # Authorize bypass for every env during dev.

    # Check payload
    return invalid_authentication if check_payload

    load_current_user!
    invalid_authentication unless @current_user
  end

  # Returns 401 response. To handle malformed / invalid requests.
  def invalid_authentication
    render json: { error: 'Invalid Request' }, status: :unauthorized
  end

  def pass_scope(data = {})
    {
      current_user: current_user
    }.merge(data)
  end

  private

  # Check payload validity
  def check_payload
    !payload || !JwtTokenLib.valid_payload(payload.first)
  end

  # Deconstructs the Authorization header and decodes the JWT token.
  def payload
    auth_header = request.headers['Authorization']
    token = auth_header.split(' ').last
    JwtTokenLib.decode(token)
  rescue StandardError => _
    nil
  end

  # Sets the @current_user with the user_id from payload
  def load_current_user!
    @current_user = User.find_by(uuid: payload[0]['uuid'])
    @current_user.update(last_connected_at: Time.zone.now)
  end
end
