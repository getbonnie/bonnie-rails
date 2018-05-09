FactoryBot.define do
  factory :user do
    sequence :name do |n|
      "name #{n}"
    end
  end
end
