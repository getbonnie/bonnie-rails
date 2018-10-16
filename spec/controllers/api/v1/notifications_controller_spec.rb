require 'rails_helper'
# !
RSpec.describe Api::V1::NotificationsController, type: :controller do
  it 'works' do
    user = create(:user)
    create_list(:notification, 10, user_id: user.id)

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
end
