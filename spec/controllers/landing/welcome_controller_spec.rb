require 'rails_helper'

#
RSpec.describe Landing::WelcomeController, type: :controller do
  it 'works' do
    get :root
    expect(response.status).to eq(200)
  end
end
