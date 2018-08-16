require 'rails_helper'

#
RSpec.describe Api::V1::PlaysController, type: :controller do
  it 'plays comment successfully' do
    comment = create(:comment)

    request.headers[:user] = create(:user).id
    post :create, params: { type: 'comment', uuid: comment.uuid }

    expect(response.status).to eq(200)
  end

  it 'plays comment with error' do
    request.headers[:user] = create(:user).id
    post :create, params: { type: 'comment', uuid: 'Error' }

    expect(response.status).to eq(500)
  end

  it 'plays pew successfully' do
    pew = create(:pew)

    request.headers[:user] = create(:user).id
    post :create, params: { type: 'pew', uuid: pew.uuid }

    expect(response.status).to eq(200)
  end

  it 'plays pew with error' do
    request.headers[:user] = create(:user).id
    post :create, params: { type: 'pew', uuid: 'Error' }

    expect(response.status).to eq(500)
  end
end
