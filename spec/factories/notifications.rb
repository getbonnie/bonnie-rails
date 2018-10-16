FactoryBot.define do
  factory :notification do
    association :notificationable, factory: :pew
    association :from, factory: :user
    user

    kind { 1 }
  end
end
