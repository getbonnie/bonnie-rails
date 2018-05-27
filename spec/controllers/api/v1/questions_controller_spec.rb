require 'rails_helper'

#
RSpec.describe Api::V1::QuestionsController, type: :controller do
  it 'succeeds' do
    question = create(:question)
    create_list(:reaction, 3, question_id: question.id)

    request.headers[:user] = create(:user).id
    get :reactions, params: { uuid: question.uuid }
    expect(response.status).to eq(200)
  end

  it 'fails' do
    request.headers[:user] = create(:user).id
    get :reactions, params: { uuid: 'MISSING' }
    expect(response.status).to eq(404)
  end
end
