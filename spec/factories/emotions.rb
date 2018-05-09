FactoryBot.define do
  factory :emotion do
    sequence :name do |n|
      "emotion #{n}"
    end

    state 'active'
  end
end
