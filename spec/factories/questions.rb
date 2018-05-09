FactoryBot.define do
  factory :question do
    category
    topic

    sequence :short do |n|
      "short #{n}"
    end

    sequence :long do |n|
      "long #{n}"
    end

    sequence :question do |n|
      "question #{n}"
    end

    state 'active'
  end
end
