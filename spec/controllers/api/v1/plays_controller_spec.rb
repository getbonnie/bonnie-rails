require 'rails_helper'

#
RSpec.describe Api::V1::PlaysController, type: :controller do
  it 'plays comment successfully' do
    comment = create(:comment)

    request.headers[:user] = create(:user).id
    post :comment, params: { uuid: comment.uuid }

    expect(response.status).to eq(200)
  end

  it 'plays comment with error' do
    request.headers[:user] = create(:user).id
    post :comment, params: { uuid: 'Error' }

    expect(response.status).to eq(404)
  end

  it 'plays reaction successfully' do
    reaction = create(:reaction)

    request.headers[:user] = create(:user).id
    post :reaction, params: { uuid: reaction.uuid }

    expect(response.status).to eq(200)
  end

  it 'plays reaction with error' do
    request.headers[:user] = create(:user).id
    post :reaction, params: { uuid: 'Error' }

    expect(response.status).to eq(404)
  end
end
