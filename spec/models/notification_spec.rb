require 'rails_helper'
# !
RSpec.describe Notification, type: :model do
  subject { described_class.new }

  it 'is not valid without valid attributes' do
    expect(subject).to_not be_valid
  end

  it 'is valid with valid attributes' do
    subject.notificationable = create(:pew)
    subject.user_id = create(:user).id
    subject.from_id = create(:user).id
    subject.kind = :like
    expect(subject).to be_valid

    subject.save!
  end
end
