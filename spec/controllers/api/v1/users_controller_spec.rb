require 'rails_helper'

#
RSpec.describe Api::V1::UsersController, type: :controller do
  it 'suspends account' do
    user = create(:user)
    request.headers[:user] = user.id
    put :suspend

    expect(response.status).to eq(200)
    expect(user.reload.status).to eq('suspended')
  end

  it 'fails with no header' do
    get :me

    expect(response.status).to eq(401)
  end

  it 'succeed me with valid header' do
    user = create(:user)
    user.avatar.attach(fixture_file_upload(Rails.root.join('spec', 'fixtures', 'test.png'), 'image/png'))
    emotion = create(:emotion)
    create(:pew, emotion_id: emotion.id)

    request.headers[:user] = user.id
    get :me

    expect(response.status).to eq(200)
  end

  it 'get success' do
    request.headers[:user] = create(:user).id
    get :show, params: { uuid: create(:user).uuid }

    expect(response.status).to eq(200)
  end

  it 'get pews' do
    user = create(:user)
    create_list(:pew, 3, user_id: user.id)

    request.headers[:user] = user.id
    get :pews, params: { uuid: user.uuid }

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

  it 'fails with similar name' do
    create(:user, name: 'my_name')
    user = create(:user, name: 'my_name')

    payload = {
      user: {
        name: 'my_name'
      }
    }
    request.headers[:user] = user.id
    put :update, params: payload
    expect(response.status).to eq(500)
  end

  it 'get followers' do
    user = create(:user)
    create_list(:follower, 3, followed_id: user.id)

    request.headers[:user] = create(:user).id
    get :followers, params: { uuid: user.uuid }

    expect(response.status).to eq(200)
  end

  it 'get following' do
    user = create(:user)
    create_list(:follower, 3, user_id: user.id)

    request.headers[:user] = create(:user).id
    get :following, params: { uuid: user.uuid }

    expect(response.status).to eq(200)
  end

  it 'activates successfully' do
    user = create(:user, status: :pending)
    user.avatar = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'test.png'), 'image/png')
    user.save

    request.headers[:user] = user.id
    get :activate

    expect(response.status).to eq(200)
  end

  it 'activates with all errors' do
    create(:user, name: 'my_name')

    user = create(:user, status: :pending, name: 'my_name', birthdate: nil)

    request.headers[:user] = user.id
    get :activate

    expect(response.status).to eq(500)
    expect(JSON.parse(response.body)['errors'].length).to eq(3)
  end
end
