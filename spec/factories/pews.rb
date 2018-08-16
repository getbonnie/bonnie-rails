FactoryBot.define do
  factory :pew do
    emotion
    user

    hashtag { 'neymar' }
    duration { 100 }
    status { 'active' }
  end
end
