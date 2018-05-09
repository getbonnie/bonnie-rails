FactoryBot.define do
  factory :reaction do
    emotion
    question
    user

    state 'active'
  end
end
