require 'rails_helper'

#
RSpec.describe Play, type: :model do
  subject { described_class.new }

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
