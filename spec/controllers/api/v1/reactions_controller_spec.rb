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
        emotion_id: emotion.id
      }
    }
    request.headers[:user] = user.id
    get :create, params: payload
    expect(response.status).to eq(200)
  end
end
