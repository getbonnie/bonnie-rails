require 'rails_helper'

#
RSpec.describe Emotion, type: :model do
  subject { described_class.new }

  it 'has states' do
    expect(Emotion.states.size).to be > 1
  end

  it 'is not valid without valid attributes' do
    expect(subject).to_not be_valid
  end

  it 'is valid with valid attributes' do
    subject.name = 'name'
    expect(subject).to be_valid

    subject.save!
    expect(subject.state).to eq('pending')
  end
end
