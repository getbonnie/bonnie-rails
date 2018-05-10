require 'rails_helper'

#
RSpec.describe Reaction, type: :model do
  subject { described_class.new }

  it 'is not valid without valid attributes' do
    expect(subject).to_not be_valid
  end

  it 'is valid with valid attributes' do
    subject.question_id = create(:question).id
    subject.user_id = create(:user).id
    subject.emotion_id = create(:emotion).id
    expect(subject).to be_valid

    subject.save!
    expect(subject.pending?).to be true
    expect(subject.uuid).to match(@uuid_regex)
  end
end
