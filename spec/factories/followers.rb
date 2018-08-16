FactoryBot.define do
  factory :follower do
    association :follower, factory: :user
    association :following, factory: :user
  end
end
