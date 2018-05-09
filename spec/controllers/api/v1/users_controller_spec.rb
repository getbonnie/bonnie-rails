require 'rails_helper'

#
RSpec.describe Api::V1::UsersController, type: :controller do
  it 'fails with no header' do
    post :me
    expect(response.status).to eq(401)
  end

  it 'succeed with valid header' do
    user = create(:user)

    request.headers[:user] = user.id
    post :me
    expect(response.status).to eq(200)
  end
end
