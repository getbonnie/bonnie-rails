require 'rails_helper'

#
RSpec.describe User, type: :model do
  subject { described_class.new }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid

    subject.save!
    expect(subject.pending?).to be true
    expect(subject.uuid).to match(@uuid_regex)
  end

  it 'check pew counters' do
    pew = create(:pew)

    expect(pew.user.pews_count).to eq(1)
  end

  it 'check comment counters' do
    comment = create(:comment)

    expect(comment.user.comments_count).to eq(1)
  end
end
