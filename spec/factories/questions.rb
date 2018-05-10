FactoryBot.define do
  factory :question do
    category
    topic
    classification

    sequence :short do |n|
      "short #{n}"
    end

    sequence :long do |n|
      "long #{n}"
    end

    status 'active'
  end
end
