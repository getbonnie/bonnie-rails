FactoryBot.define do
  factory :topic do
    category

    sequence :name do |n|
      "tag #{n}"
    end

    status 'active'
  end
end
