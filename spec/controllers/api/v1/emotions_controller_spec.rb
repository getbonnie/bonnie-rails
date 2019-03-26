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

  it 'gets manifest' do
    emotion = create(:emotion, emoji: 'TEST', updated_at: '2010/10/10 10:10')

    request.headers[:user] = create(:user).id
    get :manifest

    manifest = "#{Digest::MD5.hexdigest(emotion.id.to_s + emotion.created_at.to_s)}"

    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)['data']['manifest']).to eq(manifest)

    # Check new manifest
    emotion = create(:emotion, emoji: 'TEST', updated_at: '2011/10/10 10:10')

    request.headers[:user] = create(:user).id
    get :manifest

    manifest = "#{Digest::MD5.hexdigest(emotion.id.to_s + emotion.created_at.to_s)}"

    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)['data']['manifest']).to eq(manifest)
  end
end
