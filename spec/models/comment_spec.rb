require 'rails_helper'

#
RSpec.describe Comment, type: :model do
  subject { described_class.new }

  it 'has states' do
    expect(Comment.states.size).to be > 1
  end

  it 'is not valid without valid attributes' do
    expect(subject).to_not be_valid
  end

  it 'is valid with valid attributes' do
    subject.user_id = create(:user).id
    subject.emotion_id = create(:emotion).id
    subject.reaction_id = create(:reaction).id
    expect(subject).to be_valid

    subject.save!
    expect(subject.state).to eq('pending')
    expect(subject.uuid).to match(@uuid_regex)
  end
end
