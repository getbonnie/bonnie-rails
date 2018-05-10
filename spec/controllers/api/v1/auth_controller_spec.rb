require 'rails_helper'

#
RSpec.describe Api::V1::AuthController, type: :controller do
  it 'fails' do
    payload = {
      auth: {
        uid: 'wrong_uid',
        id_token: 'id_token'
      }
    }
    post :check, params: payload

    expect(response).to be_server_error
  end

  it 'works' do
    payload = {
      auth: {
        uid: 'uid',
        id_token: 'id_token'
      }
    }
    post :check, params: payload

    expect(User.first.ref_firebase).to eq('uid')
    expect(User.first.phone).to eq('phoneNumber')
  end
end
