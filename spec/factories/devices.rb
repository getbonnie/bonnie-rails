FactoryBot.define do
  factory :device do
    user

    sequence :reference do |n|
      "reference #{n}"
    end

    sequence :token do |n|
      "token #{n}"
    end
  end
end
