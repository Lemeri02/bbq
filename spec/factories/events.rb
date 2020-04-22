FactoryBot.define do
  factory :event do
    association :user

    title { "Barbecue_#{rand(100)}" }
    description { "Hold my beer" }
    address { "Moscow, Lubyanka 2" }
    datetime { 2.days.from_now }
  end
end
