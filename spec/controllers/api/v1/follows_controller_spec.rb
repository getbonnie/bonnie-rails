require 'rails_helper'

#
RSpec.describe Api::V1::FollowsController, type: :controller do
  it 'works' do
    target = create(:user)

    request.headers[:user] = create(:user).id
    post :create, params: { uuid: target.uuid }

    expect(response.status).to eq(200)

    expect(Follower.count).to eq(1)
  end

  it 'deletes' do
    target = create(:user)
    user = create(:user)

    create(:follower, user_id: user.id, followed_id: target.id)

    request.headers[:user] = user.id
    delete :delete, params: { uuid: target.uuid }

    expect(response.status).to eq(200)

    expect(Follower.count).to eq(0)
  end

  it 'dont work with same user' do
    target = create(:user)

    request.headers[:user] = target.id
    post :create, params: { uuid: target.uuid }

    expect(response.status).to eq(500)

    expect(Follower.count).to eq(0)
  end
end
