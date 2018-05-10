#
class Api::V1::AuthController < Api::V1::BaseController
  skip_before_action :authenticate_request!, only: %i[check]

  def check
    auth_params = params.require(:auth).permit(
      :uid,
      :id_token
    ).tap do |i|
      i.require(:uid)
      i.require(:id_token)
    end

    firebase = get_firebase_id(auth_params)
    api_error(status: 500, errors: 'FirebaseId missing') and return false unless firebase

    # Generate or fetch user
    user = first_or_create_user(firebase)
    api_error(status: 500, errors: 'User missing') and return false if user.nil?

    jwt = JwtTokenLib.encode(uuid: user.uuid)

    render json: {
      data: {
        jwt: jwt
      }
    }
  end

  private

  def get_firebase_id(auth_params)
    id_token = auth_params.fetch(:id_token)
    return nil unless id_token

    # Bypass Firebase for local usage
    firebase_data = FirebaseLib.verification(id_token)
    firebase_id = firebase_data.fetch('user').fetch('uid')

    # Compare Ids from JSON and from Firebase
    return nil if auth_params.fetch(:uid) != firebase_id

    firebase_data.fetch('user')
  end

  def first_or_create_user(firebase)
    uid = firebase.fetch('uid')

    user = User.find_by(ref_firebase: uid)

    if user.nil?
      data = {
        phone: firebase.fetch('phoneNumber'),
        ref_firebase: uid
      }
      user = User.create(data)
    end

    user
  end
end
