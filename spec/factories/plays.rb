FactoryBot.define do
  factory :play do
    user

    association :playable, factory: :reaction
  end
end
