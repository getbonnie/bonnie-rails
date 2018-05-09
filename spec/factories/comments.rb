FactoryBot.define do
  factory :comment do
    reaction
    emotion
    user

    state 'active'
  end
end
