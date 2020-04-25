FactoryBot.define do
  factory :comment do
    association :event
    association :user

    body { "Comment about number #{rand(1000)}" }
    user_name { "Anonym #{rand(100)}" }
  end
end
