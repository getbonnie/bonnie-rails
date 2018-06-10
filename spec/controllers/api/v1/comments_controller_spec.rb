require 'rails_helper'

#
RSpec.describe Api::V1::CommentsController, type: :controller do
  it 'gets index' do
    pew = create(:pew)
    create_list(:comment, 3, pew_id: pew.id)

    request.headers[:user] = create(:user).id
    get :index, params: { uuid: pew.uuid }

    expect(response.status).to eq(200)
  end

  it 'fails with index' do
    request.headers[:user] = create(:user).id
    get :index, params: { uuid: 'ISSUE' }

    expect(response.status).to eq(404)
  end

  it 'posts successfully' do
    pew = create(:pew)
    comment = create(:comment, pew_id: pew.id)

    payload = {
      uuid: pew.uuid,
      comment: {
        emotion_id: create(:emotion).id,
        comment_uuid: comment.uuid,
        sound: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'test.wav'), 'audio/wav')
      }
    }
    request.headers[:user] = create(:user).id
    post :create, params: payload

    expect(response.status).to eq(200)
  end

  it 'fails post with previous comment missing' do
    pew = create(:pew)

    payload = {
      uuid: pew.uuid,
      comment: {
        emotion_id: create(:emotion).id,
        comment_uuid: 'Error',
        sound: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'test.wav'), 'audio/wav')
      }
    }
    request.headers[:user] = create(:user).id
    post :create, params: payload

    expect(response.status).to eq(500)
  end
end
