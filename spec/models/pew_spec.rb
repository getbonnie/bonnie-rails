require 'rails_helper'

#
RSpec.describe Pew, type: :model do
  subject { described_class.new }

  it 'is not valid without valid attributes' do
    expect(subject).to_not be_valid
  end

  it 'is valid with valid attributes' do
    subject.user_id = create(:user).id
    subject.emotion_id = create(:emotion).id
    subject.duration = 100
    expect(subject).to be_valid

    subject.save!
    expect(subject.pending?).to be true
    expect(subject.uuid).to match(@uuid_regex)
  end
end
