require 'rails_helper'

# !
RSpec.describe Api::V1::DevicesController, type: :controller do
  it 'touches' do
    user = create(:user)

    Device.delete_all

    payload = {
      device: {
        reference: 'ref',
        token: 'tok'
      }
    }

    request.headers[:user] = user.id
    put :touch, params: payload

    expect(response.status).to eq(200)

    expect(Device.count).to eq(1)
    expect(Device.first.reference).to eq('ref')
    expect(Device.first.token).to eq('tok')
  end
end
