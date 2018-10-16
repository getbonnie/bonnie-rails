require 'rails_helper'
# !
RSpec.describe Api::V1::HashtagsController, type: :controller do
  it 'works' do
    create_list(:pew, 10)

    request.headers[:user] = create(:user).id
    get :index

    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)['data'].length).to eq(1)
  end

  it 'works for search' do
    create_list(:pew, 10)
    create(:pew, hashtag: 'test')

    request.headers[:user] = create(:user).id
    get :index, params: { keyword: 'te' }

    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)['data'].length).to eq(1)
  end
end
