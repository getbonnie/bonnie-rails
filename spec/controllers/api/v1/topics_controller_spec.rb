require 'rails_helper'

#
RSpec.describe Api::V1::TopicsController, type: :controller do
  it 'succeed' do
    request.headers[:user] = create(:user).id
    get :show, params: { uuid: create(:topic).uuid }
    expect(response.status).to eq(200)
  end

  it 'fails' do
    request.headers[:user] = create(:user).id
    get :show, params: { uuid: 'ERROR' }
    expect(response.status).to eq(404)
  end
end
