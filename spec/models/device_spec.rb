require 'rails_helper'

#
RSpec.describe Device, type: :model do
  subject { described_class.new }

  it 'is not valid without valid attributes' do
    expect(subject).to_not be_valid
  end

  it 'is valid with valid attributes' do
    subject.reference = 'UUID'
    subject.token = 'UUID'
    subject.user_id = create(:user).id
    expect(subject).to be_valid
  end
end
