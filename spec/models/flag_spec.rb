require 'rails_helper'

#
RSpec.describe Flag, type: :model do
  subject { described_class.new }

  it 'is not valid without valid attributes' do
    expect(subject).to_not be_valid
  end

  it 'is valid with valid attributes' do
    subject.user_id = create(:user).id
    subject.flagable_id = create(:reaction).id
    subject.flagable_type = 'Reaction'
    subject.kind = 'spam'
    expect(subject).to be_valid

    subject.save!
    expect(subject.pending?).to be true
  end
end
