require 'rails_helper'

#
RSpec.describe Question, type: :model do
  subject { described_class.new }

  it 'has states' do
    expect(Question.states.size).to be > 1
  end

  it 'is not valid without valid attributes' do
    expect(subject).to_not be_valid
  end

  it 'is valid with valid attributes' do
    subject.topic_id = create(:topic).id
    subject.short = 'short'
    expect(subject).to be_valid

    subject.save!
    expect(subject.state).to eq('pending')
    expect(subject.uuid).to match(@uuid_regex)
  end

  it 'check reaction counters' do
    reaction = create(:reaction)

    expect(reaction.question.reactions_count).to eq(1)
  end
end
