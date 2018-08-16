require 'rails_helper'

#
RSpec.describe 'CacheSerializer' do
  it 'is valid' do
    emotions = create_list(:emotion, 3)

    data = Api::V1::GoogleCloud::CacheSerializer.new({}).to_hash

    expect(data[:emotions].size).to be > 1
    expect(data[:generated_at]).to eq(Time.zone.today.to_s)
  end
end
