FactoryBot.define do
  factory :user do
    sequence :name do |n|
      "name #{n}"
    end

    status 'active'
  end
end
