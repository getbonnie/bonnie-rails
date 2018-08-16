FactoryBot.define do
  factory :user_image do
    user

    reference { 'UUID' }
  end
end
