require 'rails_helper'
# !
RSpec.describe Api::V1::LikesController, type: :controller do
  it 'works with pew' do
    pew1 = create(:pew, user_id: create(:user).id)
    pew2 = create(:pew, user_id: create(:user).id)

    user1 = create(:user)
    create_like(pew1, user1, 1, 1)

    expect(Notification.last.user_id).to eq(pew1.user_id)

    user2 = create(:user)
    create_like(pew1, user2, 2, 2)

    user3 = create(:user)
    create_like(pew1, user3, 3, 3)

    delete_like(pew1, user1, 2)

    create_like(pew2, user3, 1, 4)
    delete_like(pew2, user3, 0)
  end

  it 'works with commments' do
    comment = create(:comment, user_id: create(:user).id)

    expect(Notification.where(kind: :like).count).to eq(0)

    request.headers[:user] = create(:user).id
    post :create, params: { type: 'comment', uuid: comment.uuid }

    expect(response.status).to eq(200)

    expect(comment.reload.likes_count).to eq(1)
    expect(Notification.where(kind: :like).count).to eq(1)
    expect(Notification.where(kind: :like).last.user_id).to eq(comment.user_id)
  end

  it 'destroys' do
    user = create(:user)
    like = create(:like, likable: create(:pew), user: user)

    request.headers[:user] = user.id
    delete :delete, params: { type: 'pew', uuid: like.likable.uuid }

    expect(response.status).to eq(200)

    expect(like.likable.reload.likes_count).to eq(0)
  end

  def create_like(pew, user, count, count_notification = nil)
    request.headers[:user] = user.id
    post :create, params: { type: 'pew', uuid: pew.uuid }

    expect(response.status).to eq(200)

    expect(pew.reload.likes_count).to eq(count)
    return false unless count_notification

    expect(Notification.where(kind: :like).count).to eq(count_notification)
  end

  def delete_like(pew, user, count)
    request.headers[:user] = user.id
    delete :delete, params: { type: 'pew', uuid: pew.uuid }

    expect(response.status).to eq(200)

    expect(pew.reload.likes_count).to eq(count)
  end
end
