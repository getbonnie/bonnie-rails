require 'rails_helper'

#
RSpec.describe Api::V1::TopicsController, type: :controller do
  it 'succeed' do
    create(:topic)

    request.headers[:user] = create(:user).id
    get :index
    expect(response.status).to eq(200)
  end
end
