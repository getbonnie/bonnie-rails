require 'rails_helper'

#
RSpec.describe Api::V1::AuthController, type: :controller do
  it 'fails' do
    payload = {
      auth: {
        uid: 'wrong_uid',
        id_token: 'id_token',
        phone_number: '+3300000'
      }
    }
    post :check, params: payload

    expect(response).to be_server_error
  end

  it 'works' do
    payload = {
      auth: {
        uid: 'uid',
        id_token: 'id_token',
        phone_number: '+3300000'
      }
    }
    post :check, params: payload

    user = User.first

    expect(user.ref_firebase).to eq('uid')
    expect(user.phone).to eq('+3300000')

    jwt = JSON.parse(response.body).dig('data', 'jwt')

    # Checking validity
    request.headers['Authorization'] = "Bearer #{jwt}"
    @controller = Api::V1::UsersController.new
    get :me

    uuid = JSON.parse(response.body).dig('data', 'uuid')
    expect(uuid).to eq(user.uuid)
  end
end
