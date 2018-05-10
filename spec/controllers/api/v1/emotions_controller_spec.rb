require 'rails_helper'

#
RSpec.describe Api::V1::EmotionsController, type: :controller do
  it 'fails with no header' do
    get :index
    expect(response.status).to eq(401)
  end

  it 'succeed with valid header' do
    create(:emotion)

    request.headers[:user] = create(:user).id
    get :index
    expect(response.status).to eq(200)
  end
end
