require 'rails_helper'

#
RSpec.describe Like, type: :model do
  subject { described_class.new }

  it 'is not valid without valid attributes' do
    expect(subject).to_not be_valid
  end

  it 'is valid with valid attributes' do
    subject.user_id = create(:user).id
    subject.likable = create(:pew)
    expect(subject).to be_valid
  end

  it 'is has types' do
    expect(Like.likable_types.size).to be > 0
  end
end
