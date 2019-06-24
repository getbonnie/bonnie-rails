require 'rails_helper'
# !
RSpec.describe Api::V1::PewsController, type: :controller do
  it 'deletes with notifications' do
    pew = create(:pew)
    pew_id = pew.id
    user = create(:user)

    create(:comment, pew: pew)

    Like.create(likable: pew, user: user)
    expect(Notification.where(kind: :like).count).to eq(1)

    request.headers[:user] = pew.user.id
    delete :delete, params: { uuid: pew.uuid }

    expect(response.status).to eq(200)

    expect(Pew.find_by(id: pew_id)).to be_nil
    expect(Notification.where(kind: :like).count).to eq(0)
  end

  it 'works following no one' do
    create_list(:pew, 3)

    request.headers[:user] = create(:user).id
    get :index

    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)['data'].length).to eq(0)
  end

  it 'works following 1' do
    current_user = create(:user).id
    pew = create(:pew)

    following = create(:follower, user_id: current_user, followed_id: pew.user_id)


    request.headers[:user] = current_user
    get :index

    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)['data'].length).to eq(1)
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
    content = Base64.strict_encode64(
      File.open(Rails.root.join('spec', 'fixtures', 'test.aac'), &:read)
    )
    payload = {
      pew: {
        inline_hashtags: 'ney.mar #magueule',
        emotion_id: create(:emotion).id,
        duration: 100,
        sound_base64: "data:audio/aac;base64,#{content}"
      }
    }
    request.headers[:user] = create(:user).id
    post :create, params: payload

    expect(response.status).to eq(200)
    expect(Hashtag.count).to eq(2)
    expect(Hashtag.first.tag).to eq('ney.mar')
    expect(Hashtag.last.tag).to eq('magueule')
  end

  it 'gets pew with success' do
    pew = create(:pew)

    request.headers[:user] = create(:user).id
    get :show, params: { uuid: pew.uuid }

    expect(response.status).to eq(200)
  end

  it 'edit pew with success' do
    pew = create(:pew)
    emotion = create(:emotion)

    payload = {
      pew: {
        inline_hashtags: 'wesh ma gueule',
        emotion_id: emotion.id
      }
    }

    request.headers[:user] = pew.user.id
    get :update, params: { uuid: pew.uuid }.merge(payload)

    expect(response.status).to eq(200)
    expect(pew.reload.inline_hashtags).to eq('wesh ma gueule')
    expect(pew.reload.emotion_id).to eq(emotion.id)
  end

  it 'fails getting pew' do
    request.headers[:user] = create(:user).id
    get :show, params: { uuid: 'MISSING' }

    expect(response.status).to eq(404)
  end
end
