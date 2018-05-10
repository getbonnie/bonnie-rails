FactoryBot.define do
  factory :comment do
    reaction
    emotion
    user

    status 'active'
  end
end
