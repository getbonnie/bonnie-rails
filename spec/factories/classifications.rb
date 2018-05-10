FactoryBot.define do
  factory :classification do
    sequence :name do |n|
      "classification #{n}"
    end

    status 'active'
  end
end
