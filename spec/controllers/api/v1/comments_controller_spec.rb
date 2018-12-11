require 'rails_helper'
# !
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

    # First comment
    comment = create(:comment, pew_id: pew.id)

    content = Base64.strict_encode64(
      File.open(Rails.root.join('spec', 'fixtures', 'test.aac'), &:read)
    )

    # Related comment
    payload = {
      uuid: pew.uuid,
      comment: {
        emotion_id: create(:emotion).id,
        comment_uuid: comment.uuid,
        duration: 100,
        sound_base64: "data:audio/aac;base64,#{content}"
      }
    }
    request.headers[:user] = create(:user).id
    post :create, params: payload

    expect(response.status).to eq(200)

    expect(pew.reload.comments_count).to eq(2)
    expect(Notification.count).to eq(2)
  end

  it 'fails post with previous comment missing' do
    pew = create(:pew)

    payload = {
      uuid: pew.uuid,
      comment: {
        emotion_id: create(:emotion).id,
        duration: 100,
        comment_uuid: 'Error',
        sound: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'test.wav'), 'audio/wav')
      }
    }
    request.headers[:user] = create(:user).id
    post :create, params: payload

    expect(response.status).to eq(500)
  end

  it 'deletes a comment' do
    comment = create(:comment)

    payload = {
      uuid: comment.pew.uuid,
      comment_uuid: comment.uuid
    }
    request.headers[:user] = comment.user.id
    delete :delete, params: payload

    expect(response.status).to eq(200)
    expect(Comment.find_by(id: comment.id)).to be_nil
  end
end
