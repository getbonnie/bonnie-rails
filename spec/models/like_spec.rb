require 'rails_helper'

#
RSpec.describe Like, type: :model do
  subject { described_class.new }

  it 'is not valid without valid attributes' do
    expect(subject).to_not be_valid
  end

  it 'is valid with valid attributes' do
    subject.user_id = create(:user).id
    subject.likable_id = create(:reaction).id
    subject.likable_type = 'Reaction'
    expect(subject).to be_valid
  end
end
