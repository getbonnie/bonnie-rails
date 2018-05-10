require 'rails_helper'

#
RSpec.describe Classification, type: :model do
  subject { described_class.new }

  it 'is not valid without valid attributes' do
    expect(subject).to_not be_valid
  end

  it 'is valid with valid attributes' do
    subject.name = 'name'
    expect(subject).to be_valid

    subject.save!
    expect(subject.active?).to be true
  end

  it 'check question counter' do
    question = create(:question)

    expect(question.classification.questions_count).to eq(1)
  end
end
