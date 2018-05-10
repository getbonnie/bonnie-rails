require 'rails_helper'

#
RSpec.describe Api::V1::UsersController, type: :controller do
  it 'fails with no header' do
    get :me
    expect(response.status).to eq(401)
  end

  it 'succeed with valid header' do
    user = create(:user)
    emotion = create(:emotion)
    create(:reaction, emotion_id: emotion.id)

    request.headers[:user] = user.id
    get :me
    expect(response.status).to eq(200)
  end
end
