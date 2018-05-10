FactoryBot.define do
  factory :reaction do
    emotion
    question
    user

    status 'active'
  end
end
