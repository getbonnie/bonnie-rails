require 'rails_helper'

#
RSpec.describe Follower, type: :model do
  subject { described_class.new }

  it 'is valid with valid attributes' do
    subject.user = create(:user)
    subject.followed = create(:user)
    expect(subject).to be_valid
  end
end
