require 'rails_helper'

#
RSpec.describe Play, type: :model do
  subject { described_class.new }

  it 'has playable class' do
    expect(Play.playable_types.size).to be > 1
  end

  it 'is not valid without valid attributes' do
    expect(subject).to_not be_valid
  end

  it 'is valid with valid attributes' do
    subject.user_id = create(:user).id
    subject.playable_id = create(:reaction).id
    subject.playable_type = 'Reaction'
    expect(subject).to be_valid
  end
end
