FactoryBot.define do
  factory :category do
    sequence :name do |n|
      "tag #{n}"
    end

    color '#ffffff'
    status 'active'
  end
end
