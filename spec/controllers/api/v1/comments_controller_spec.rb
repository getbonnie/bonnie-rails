require 'rails_helper'

#
RSpec.describe Api::V1::CommentsController, type: :controller do
  it 'gets index' do
    reaction = create(:reaction)
    create_list(:comment, 3, reaction_id: reaction.id)

    request.headers[:user] = create(:user).id
    get :index_reactions, params: { uuid: reaction.uuid }

    expect(response.status).to eq(200)
  end

  it 'fails with index' do
    request.headers[:user] = create(:user).id
    get :index_reactions, params: { uuid: 'ISSUE' }

    expect(response.status).to eq(404)
  end

  it 'posts successfully' do
    reaction = create(:reaction)
    comment = create(:comment, reaction_id: reaction.id)

    payload = {
      uuid: reaction.uuid,
      comment: {
        emotion_id: create(:emotion).id,
        comment_uuid: comment.uuid,
        sound: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'test.wav'), 'audio/wav')
      }
    }
    request.headers[:user] = create(:user).id
    post :create_reaction, params: payload

    expect(response.status).to eq(200)
  end

  it 'fails post with previous comment missing' do
    reaction = create(:reaction)

    payload = {
      uuid: reaction.uuid,
      comment: {
        emotion_id: create(:emotion).id,
        comment_uuid: 'Error',
        sound: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'test.wav'), 'audio/wav')
      }
    }
    request.headers[:user] = create(:user).id
    post :create_reaction, params: payload

    expect(response.status).to eq(500)
  end
end
