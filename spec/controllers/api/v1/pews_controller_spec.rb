require 'rails_helper'

#
RSpec.describe Api::V1::PewsController, type: :controller do
  it 'works' do
    create_list(:pew, 3)

    request.headers[:user] = create(:user).id
    get :index

    expect(response.status).to eq(200)
  end

  it 'fails for missing params' do
    payload = {
      pew: {
        emotion_id: create(:emotion).id
      }
    }
    request.headers[:user] = create(:user).id
    get :create, params: payload

    expect(response.status).to eq(500)
  end

  it 'creates' do
    payload = {
      pew: {
        hashtag: 'neymar',
        emotion_id: create(:emotion).id,
        duration: 100,
        sound: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'test.wav'), 'audio/wav')
      }
    }
    request.headers[:user] = create(:user).id
    post :create, params: payload

    expect(response.status).to eq(200)
  end

  it 'gets pew with success' do
    pew = create(:pew)

    request.headers[:user] = create(:user).id
    get :show, params: { uuid: pew.uuid }

    expect(response.status).to eq(200)
  end

  it 'fails getting pew' do
    request.headers[:user] = create(:user).id
    get :show, params: { uuid: 'MISSING' }

    expect(response.status).to eq(404)
  end
end
