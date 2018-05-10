require 'rails_helper'

#
RSpec.describe Notification, type: :model do
  subject { described_class.new }

  it 'is not valid without valid attributes' do
    expect(subject).to_not be_valid
  end

  it 'is valid with valid attributes' do
    subject.user_id = create(:user).id
    subject.user_id_from = create(:user).id
    subject.type = :like
    expect(subject).to be_valid

    subject.save!
  end
end
