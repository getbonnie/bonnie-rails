require 'rails_helper'

#
RSpec.describe Api::V1::FeedsController, type: :controller do
  it 'succeeds' do
    create_list(:reaction, 4)
    create_list(:reaction, 5, question_id: create(:question).id)
    create_list(:reaction, 5, question_id: create(:question).id)
    create_list(:reaction, 5, question_id: create(:question).id)

    request.headers[:user] = create(:user).id
    get :index

    expect(response.status).to eq(200)

    expect(Feed.count).to eq(7)
    expect(Feed.where(source: :question_first_pass).count).to eq(1)
    expect(Feed.where(source: :question_last_pass).count).to eq(2)
  end
end
