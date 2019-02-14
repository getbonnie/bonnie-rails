require 'rails_helper'
# !
RSpec.describe Hashtag, type: :model do
  subject { described_class.new }

  it 'is not valid without valid attributes' do
    expect(subject).to_not be_valid
  end

  it 'is valid with valid attributes' do
    subject.pew_id = create(:pew).id
    subject.tag = 'Hash'
    expect(subject).to be_valid
  end
end
