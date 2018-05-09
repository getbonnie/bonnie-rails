require 'rails_helper'

#
RSpec.describe Flag, type: :model do
  subject { described_class.new }

  it 'has states' do
    expect(Flag.states.size).to be > 1
  end

  it 'has types' do
    expect(Flag.types.size).to be > 1
  end

  it 'has flagable class' do
    expect(Flag.flagable_types.size).to be > 1
  end

  it 'is not valid without valid attributes' do
    expect(subject).to_not be_valid
  end

  it 'is valid with valid attributes' do
    subject.user_id = create(:user).id
    subject.flagable_id = create(:reaction).id
    subject.flagable_type = 'Reaction'
    expect(subject).to be_valid

    subject.save!
    expect(subject.state).to eq('pending')
  end
end
