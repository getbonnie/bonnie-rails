FactoryBot.define do
  factory :category do
    sequence :name do |n|
      "tag #{n}"
    end

    color '#ffffff'
    state 'active'
  end
end
