require 'rails_helper'

#
RSpec.describe Api::V1::LikesController, type: :controller do
  it 'works with pew' do
    pew = create(:pew, user_id: create(:user).id)

    request.headers[:user] = create(:user).id
    post :create, params: { type: 'pew', uuid: pew.uuid }

    expect(response.status).to eq(200)

    expect(pew.reload.likes_count).to eq(1)
  end

  it 'works with commments' do
    comment = create(:comment, user_id: create(:user).id)

    request.headers[:user] = create(:user).id
    post :create, params: { type: 'comment', uuid: comment.uuid }

    expect(response.status).to eq(200)

    expect(comment.reload.likes_count).to eq(1)
  end
end
