FactoryBot.define do
  factory :feed do
    association :feedable, factory: :reaction
  end
end
