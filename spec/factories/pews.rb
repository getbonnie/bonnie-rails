FactoryBot.define do
  factory :pew do
    emotion
    user

    inline_hashtags { 'neymar magueule' }
    duration { 100 }
    status { 'active' }
  end
end
