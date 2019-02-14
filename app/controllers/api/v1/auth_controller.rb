# !
class Api::V1::AuthController < Api::V1::BaseController
  skip_before_action :authenticate_request!, only: %i[check]

  def check
    auth_params = params.require(:auth).permit(
      :id_token,
      :phone_number,
      :uid
    ).tap do |i|
      i.require(:id_token)
      i.require(:phone_number)
      i.require(:uid)
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
    # firebase_data = {
    #   'users' => [
    #     {
    #       'localId' => 'uid',
    #       'phoneNumber' => '+3300000'
    #     }
    #   ]
    # }
    firebase_data = firebase_data.fetch('users')[0]

    firebase_id = firebase_data.fetch('localId')
    phone_number = firebase_data.fetch('phoneNumber')

    # Compare Ids from JSON and from Firebase
    return nil if auth_params.fetch(:uid) != firebase_id || auth_params.fetch(:phone_number) != phone_number

    firebase_data
  end

  def first_or_create_user(firebase)
    uid = firebase.fetch('localId')

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
