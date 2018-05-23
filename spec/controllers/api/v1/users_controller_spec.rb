require 'rails_helper'

#
RSpec.describe Api::V1::UsersController, type: :controller do
  it 'fails with no header' do
    get :me
    expect(response.status).to eq(401)
  end

  it 'succeed me with valid header' do
    user = create(:user)
    user.avatar.attach(fixture_file_upload(Rails.root.join('spec', 'fixtures', 'test.png'), 'image/png'))
    emotion = create(:emotion)
    create(:reaction, emotion_id: emotion.id)

    request.headers[:user] = user.id
    get :me
    expect(response.status).to eq(200)
  end

  it 'get success' do
    user = create(:user)
    emotion = create(:emotion)
    create(:reaction, emotion_id: emotion.id)

    request.headers[:user] = user.id
    get :show, params: { id: create(:user).id }
    expect(response.status).to eq(200)
  end

  it 'updates' do
    user = create(:user)

    payload = {
      user: {
        name: 'changed_name',
        birthdate: '13/11/1976',
        latitude: '1',
        longitude: '2',
        avatar: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'test.png'), 'image/png')
      }
    }
    request.headers[:user] = user.id
    put :update, params: payload
    expect(response.status).to eq(200)

    user = User.find(user.id)
    expect(user.name).to eq('changed_name')
    expect(user.birthdate.strftime('%Y-%m-%d')).to eq('1976-11-13')
    expect(user.latitude).to eq(1)
    expect(user.longitude).to eq(2)
  end
end
