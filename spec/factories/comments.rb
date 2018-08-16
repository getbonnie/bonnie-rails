FactoryBot.define do
  factory :comment do
    pew
    emotion
    user

    duration { 100 }
    status { 'active' }
  end
end
