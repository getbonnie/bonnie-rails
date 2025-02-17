require 'rails_helper'
# !
RSpec.describe Api::V1::NotificationsController, type: :controller do
  it 'works' do
    user = create(:user)
    create_list(:notification, 8, user_id: user.id)
    create(:notification, user_id: user.id, mode: :reply)
    create(:notification, user_id: user.id, mode: :owner, notificationable: create(:pew, user: user), kind: :like)

    request.headers[:user] = user.id
    get :index

    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)['data'].length).to eq(10)
  end

  it 'works with pew' do
    user = create(:user)
    create_list(:notification, 10, kind: 2, user_id: user.id)

    request.headers[:user] = user.id
    get :index

    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)['data'].length).to eq(10)
  end

  it 'marks as seen' do
    user = create(:user)
    create_list(:notification, 10, user_id: user.id)

    request.headers[:user] = user.id
    put :seen

    expect(response.status).to eq(200)
    expect(Notification.where(seen: true).count).to eq(10)
  end

  it 'marks as clicked' do
    user = create(:user)

    create_list(:notification, 2, user_id: user.id)
    notification = Notification.where(user: user).first

    request.headers[:user] = user.id
    put :clicked, params: { uuid: notification.uuid }

    expect(response.status).to eq(200)
    clicked_notification = Notification.where(clicked: true).count

    expect(clicked_notification).to eq(1)
  end

  it 'counts' do
    user = create(:user)

    create_list(:notification, 2, user_id: user.id)
    request.headers[:user] = user.id
    get :count

    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)['data']['count']).to eq(2)
  end

  it 'counts comments before' do
    pew = create(:pew)

    create_list(:comment, 3, pew: pew)

    request.headers[:user] = pew.user.id
    get :index

    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)['data'][0]['comment_position']).to eq(3)
    expect(JSON.parse(response.body)['data'][1]['comment_position']).to eq(2)
    expect(JSON.parse(response.body)['data'][2]['comment_position']).to eq(1)
  end
end
