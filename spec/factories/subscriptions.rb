FactoryBot.define do
  factory :subscription do
    association :event

    sequence(:user_name) { |n| "Anastas_#{n}" }
    sequence(:user_email) do |n|
      domains = %w[yandex.ru vkontakte facebook mail.ru yahoo.com gmail.com]

      "mail#{n}@#{domains.sample}"
    end
  end
end
