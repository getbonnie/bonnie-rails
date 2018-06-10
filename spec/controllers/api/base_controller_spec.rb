require 'rails_helper'

#
RSpec.describe 'BaseController' do
  it 'meta_attributes with no collection' do
    base = Api::BaseController.new
    expect(base.meta_attributes(nil, test: 1)).to eq(test: 1)
  end

  it 'meta_attributes with collection' do
    create_list(:user, 30)

    base = Api::BaseController.new
    users = User.page(2).per(10)

    result = base.meta_attributes(users, test: 1)

    expect(result[:test]).to eq(1)
    expect(result[:current_page]).to eq(2)
    expect(result[:next_page]).to eq(3)
    expect(result[:prev_page]).to eq(1)
    expect(result[:total_pages]).to eq(3)
    expect(result[:total_count]).to eq(30)
  end
end
