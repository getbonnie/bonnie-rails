require 'rails_helper'

#
RSpec.describe Feed, type: :model do
  subject { described_class.new }

  it 'valid' do
    expect(create(:feed)).to be_valid
  end
end
