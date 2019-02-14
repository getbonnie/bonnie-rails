require 'rails_helper'

#
RSpec.describe Api::V1::FlagsController, type: :controller do
  it 'creates' do
    user = create(:user)
    pew = create(:pew)

    payload = {
      flag: {
        pew_uuid: pew.uuid,
        kind: 'spam'
      }
    }
    request.headers[:user] = user.id
    post :create, params: payload

    expect(response.status).to eq(200)
    expect(Flag.pending.count).to eq(1)
  end
end
