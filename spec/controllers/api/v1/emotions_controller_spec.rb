require 'rails_helper'
# !
RSpec.describe Api::V1::EmotionsController, type: :controller do
  it 'gets index' do
    create(:emotion, emoji: 'TEST')

    expect(Emotion.last.emoji_image).to eq('data:image/png;base64,TEST')

    request.headers[:user] = create(:user).id
    get :index

    expect(response.status).to eq(200)
  end
end
