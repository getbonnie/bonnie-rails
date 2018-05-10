require 'rails_helper'

#
RSpec.describe Emotion, type: :model do
  subject { described_class.new }

  it 'is not valid without valid attributes' do
    expect(subject).to_not be_valid
  end

  it 'is valid with valid attributes' do
    subject.name = 'name'
    expect(subject).to be_valid

    subject.save!
    expect(subject.pending?).to be true
  end

  it 'check comment counter' do
    comment = create(:comment)

    expect(comment.emotion.comments_count).to eq(1)
  end

  it 'check reaction counter' do
    reaction = create(:reaction)

    expect(reaction.emotion.reactions_count).to eq(1)
  end
end
