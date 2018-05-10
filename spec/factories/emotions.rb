FactoryBot.define do
  factory :emotion do
    sequence :name do |n|
      "emotion #{n}"
    end

    status 'active'
  end
end
