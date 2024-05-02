FactoryBot.define do
  factory :user do
    nickname {Faker::Internet.username}
    email {Faker::Internet.email}
    password {'1a' + Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    last_name {"亜あア"}
    first_name {"亜あア"}
    last_name_kana {"ア"}
    first_name_kana {"ア"}
    birth_day {Faker::Date.between(from: '1930-01-01', to: '2019-12-31')}
  end
end
