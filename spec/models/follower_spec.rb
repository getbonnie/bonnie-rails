require 'rails_helper'

#
RSpec.describe Follower, type: :model do
  subject { described_class.new }

  it 'is valid with valid attributes' do
    subject.following = create(:user)
    subject.follower = create(:user)
    expect(subject).to be_valid
  end
end
