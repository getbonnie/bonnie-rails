FactoryBot.define do
  factory :user do
    sequence :name do |n|
      "name #{n}"
    end

    birthdate { '1976/11/11' }
    status { 'active' }

    after :create do |user|
      create :device, user: user
    end
  end
end
