FactoryBot.define do
  factory :topic do
    sequence :name do |n|
      "tag #{n}"
    end

    status 'active'
  end
end
