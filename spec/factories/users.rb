FactoryBot.define do
  factory :user do
    name { "Anastas_#{rand(999)}" }

    sequence(:email) { |n| "anastas_#{n}@example.com" }

    after(:build) { |u| u.password_confirmation = u.password = "123456" }
  end
end
