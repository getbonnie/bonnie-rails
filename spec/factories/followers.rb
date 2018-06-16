FactoryBot.define do
  factory :follower do
    user
    association :followed, factory: :user
  end
end
