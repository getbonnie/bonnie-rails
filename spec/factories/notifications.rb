FactoryBot.define do
  factory :notification do
    association :notificationable, factory: :comment
    association :from, factory: :user
    user

    kind { 1 }
  end
end
