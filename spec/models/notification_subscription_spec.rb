require 'rails_helper'
# !
RSpec.describe NotificationSubscription, type: :model do
  subject { described_class.new }

  it 'is not valid without valid attributes' do
    expect(subject).to_not be_valid
  end

  it 'is valid with valid attributes' do
    subject.pew = create(:pew)
    subject.user = create(:user)
    expect(subject).to be_valid

    subject.save!
  end
end
