require 'rails_helper'

#
RSpec.describe Api::V1::LikesController, type: :controller do
  it 'fails for reaction with same user' do
    user = create(:user)
    reaction = create(:reaction, user_id: user.id)

    request.headers[:user] = user.id
    get :reaction, params: { uuid: reaction.uuid }

    expect(response.status).to eq(404)
  end

  it 'works for reaction' do
    user = create(:user)
    reaction = create(:reaction, user_id: create(:user).id)

    request.headers[:user] = user.id
    get :reaction, params: { uuid: reaction.uuid }

    expect(response.status).to eq(200)

    expect(reaction.likes_count).to eq(1)

    get :reaction, params: { uuid: reaction.uuid }
    expect(reaction.likes_count).to eq(1)
  end
end
