FactoryBot.define do
  factory :user do
    sequence :name do |n|
      "name #{n}"
    end

    birthdate { '1976/11/11' }
    status { 'active' }
  end
end
