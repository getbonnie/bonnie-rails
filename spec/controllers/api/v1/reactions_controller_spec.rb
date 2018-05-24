require 'rails_helper'

#
RSpec.describe Api::V1::ReactionsController, type: :controller do
  it 'fails for missing params' do
    user = create(:user)
    emotion = create(:emotion)

    payload = {
      reaction: {
        emotion_id: emotion.id
      }
    }
    request.headers[:user] = user.id
    get :create, params: payload

    expect(response.status).to eq(500)
  end

  it 'creates' do
    user = create(:user)
    emotion = create(:emotion)
    question = create(:question)

    payload = {
      reaction: {
        question_uuid: question.uuid,
        emotion_id: emotion.id,
        sound: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'test.wav'), 'audio/wav')
      }
    }
    request.headers[:user] = user.id
    post :create, params: payload
    expect(response.status).to eq(200)
  end

  it 'gets reaction with success' do
    user = create(:user)
    reaction = create(:reaction)

    request.headers[:user] = user.id
    get :show, params: { uuid: reaction.uuid }
    expect(response.status).to eq(200)
  end

  it 'fails getting reaction' do
    user = create(:user)

    request.headers[:user] = user.id
    get :show, params: { uuid: 'random' }
    expect(response.status).to eq(404)
  end
end
