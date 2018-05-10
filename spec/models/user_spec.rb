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
end
