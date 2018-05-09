require 'rails_helper'

#
RSpec.describe User, type: :model do
  subject { described_class.new }

  it 'has states' do
    expect(User.states.size).to be > 1
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid

    subject.save!
    expect(subject.state).to eq('pending')
    expect(subject.uuid).to match(@uuid_regex)
  end
end
